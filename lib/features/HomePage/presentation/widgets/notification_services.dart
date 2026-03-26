import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async{
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
    );
    print('permission: ${settings.authorizationStatus}');

    String token = await _firebaseMessaging.getToken() ?? "";
    print("Token is🤷‍♀️🤩 $token");

    void handleMessage(RemoteMessage message) {
      if (message == null) return;

    }

    FirebaseMessaging.onMessage.listen((RemoteMessage remotemessage){
      print('notifictaion recived');
      print(remotemessage.notification?.title);
      print(remotemessage.notification?.body);
    });
  }
  
}