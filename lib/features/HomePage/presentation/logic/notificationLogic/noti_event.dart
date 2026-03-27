part of 'noti_bloc.dart';
abstract class NotificationEvent {}

class NotificationWatchStarted extends NotificationEvent {}

class NotificationUpdated extends NotificationEvent {
  final List<NotificationModel> notifications;
  NotificationUpdated(this.notifications);
}
class NotificationErrorEvent extends NotificationEvent {
  final String message;

  NotificationErrorEvent(this.message);
}