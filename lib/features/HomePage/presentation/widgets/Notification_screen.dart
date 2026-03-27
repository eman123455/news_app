import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/Repo/notification_repo.dart';
import '../logic/notificationLogic/noti_bloc.dart';
import 'notificationWidget/notification_item.dart';
import 'notificationWidget/section_header.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationBloc(NotificationRepo())
        ..add(NotificationWatchStarted()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 24, color: Colors.black),
          ),
          title: const Text(
            'Notification',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is NotificationError) {
              return Center(child: Text(state.message));
            }
            if (state is NotificationLoaded) {
              if (state.notifications.isEmpty) {
                return const Center(child: Text('No notifications yet'));
              }

              final today = state.notifications
                  .where((n) =>
              DateTime.now().difference(n.createdAt).inDays == 0)
                  .toList();

              final older = state.notifications
                  .where((n) =>
              DateTime.now().difference(n.createdAt).inDays > 0)
                  .toList();

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  if (today.isNotEmpty) ...[
                    const SectionHeader(title: 'Today'),
                    ...today.map((n) => NotificationItem(notification: n)),
                  ],
                  if (older.isNotEmpty) ...[
                    const SectionHeader(title: 'Yesterday'),
                    ...older.map((n) => NotificationItem(notification: n)),
                  ],
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}