import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/models/notification_model/notifi_model.dart';
import '../../../Domain/Repo/notification_repo.dart';

// import 'noti_event.dart';
// import 'notif_state.dart';
part 'noti_event.dart';

part 'notif_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepo _repo;
  StreamSubscription? _subscription;

  NotificationBloc(this._repo) : super(NotificationInitial()) {
    on<NotificationWatchStarted>(_onWatchStarted);
    on<NotificationUpdated>(_onUpdated);
    on<NotificationErrorEvent>((event, emit) {
      emit(NotificationError(event.message));
    });
  }

  Future<void> _onWatchStarted(
    NotificationWatchStarted event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());

    await emit.forEach(
      _repo.listenToNotifications(),
      onData: (data) {
        final notifications = data
            .map((e) => NotificationModel.fromJson(e))
            .toList();
        return NotificationLoaded(notifications);
      },
      onError: (e, _) {
        print(e.toString());
        return NotificationError(e.toString());
      },
    );
  }

  void _onUpdated(NotificationUpdated event, Emitter<NotificationState> emit) {
    emit(NotificationLoaded(event.notifications));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
