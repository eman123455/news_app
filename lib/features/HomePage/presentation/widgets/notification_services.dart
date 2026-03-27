import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message: ${message.notification?.title}');
}

class NotificationServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  Future<void> initNotifications() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
    );
    print('Permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;



    final token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print('New FCM Token: $newToken');
    });

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
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