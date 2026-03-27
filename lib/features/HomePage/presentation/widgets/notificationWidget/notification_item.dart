import 'package:flutter/material.dart';
import '../../../Data/models/notification_model/notifi_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: notification.senderAvatar != null
                ? NetworkImage(notification.senderAvatar!)
                : null,
            child: notification.senderAvatar == null
                ? const Icon(Icons.person, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                    children: [
                      TextSpan(
                        text: notification.senderName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: ' ${notification.actionText}',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                      if (notification.newsTitle != null)
                        TextSpan(
                          text: ' "${notification.newsTitle}"',
                          style: const TextStyle(fontWeight: FontWeight.w400),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.timeAgo,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}