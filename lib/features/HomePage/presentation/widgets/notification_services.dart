import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message: ${message.notification?.title}');
}

class NotificationServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _supabase = Supabase.instance.client;

  Future<void> initNotifications() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
    );
    print('Permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;
    await _saveTokenToSupabase();

    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _upsertToken(newToken);
    });
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> _saveTokenToSupabase() async {
    final token = await _firebaseMessaging.getToken();
    if (token == null) return;
    print('FCM Token:🤩🤷‍♀️ $token');
    await _upsertToken(token);
  }

  Future<void> _upsertToken(String token) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await _supabase.from('fcm_tokens').upsert(
      {'user_id': userId, 'token': token},
      onConflict: 'user_id',
    );
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print('Notification received ✅');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');

  }

  void onNotificationTap(void Function(String postId) callback) {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final postId = message.data['post_id'];
      if (postId != null) callback(postId);
    });
  }
  Future<String?> getInitialPostId() async {
    final message = await _firebaseMessaging.getInitialMessage();
    return message?.data['post_id'];
  }
}