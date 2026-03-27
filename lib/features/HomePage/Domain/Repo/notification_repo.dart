import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Data/models/notification_model/notifi_model.dart';

class NotificationRepo {
  final _supabase = Supabase.instance.client;

  String get _currentUserId => _supabase.auth.currentUser!.id;

  Stream<List<Map<String, dynamic>>> listenToNotifications() {
    return _supabase
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('user_id', _currentUserId)
        .order('created_at', ascending: false);
  }
  Future<List<NotificationModel>> getNotifications() async {
    final response = await _supabase
        .from('notifications')
        .select()
        .eq('user_id', _currentUserId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((e) => NotificationModel.fromJson(e))
        .toList();
  }
  Future<void> markAsRead(String notificationId) async {
    await _supabase
        .from('notifications')
        .update({'is_read': true})
        .eq('id', notificationId);
  }
  Future<void> markAllAsRead() async {
    await _supabase
        .from('notifications')
        .update({'is_read': true})
        .eq('user_id', _currentUserId);
  }
}