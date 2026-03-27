import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final supabase = Supabase.instance.client;
  final AppLinks appLinks = AppLinks();
  StreamSubscription? _sub;

  Future<void> resetPassword(String email) async {
    emit(ForgetPasswordLoading());
    try {
      // Supabase v2 method
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'devcode://password-reset',
      );

      // If no exception, success
      emit(ForgetPasswordSuccess());
    } on AuthException catch (e) {
      // Supabase-specific errors
      emit(ForgetPasswordFailure(e.message));
    } catch (e) {
      // Other unexpected errors
      emit(ForgetPasswordFailure(e.toString()));
    }
  }

  Future<void> restPassword(String newPassword) async {
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  Future<void> initDeepLink() async {
    // Listen for new links while app is running
    _sub = appLinks.uriLinkStream.listen((uri) {
      if (uri != null && uri.host == 'password-reset') {
        emit(DeepLinkReceived());
      }
    });

    // Check if app was started by a link
    final initialUri = await appLinks.getInitialLink();
    if (initialUri != null && initialUri.host == 'password-reset') {
      emit(DeepLinkReceived());
    }
  }

   @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}