class NotificationModel {
  final String id;
  final String senderName;
  final String? senderAvatar;
  final String type;
  final String? newsTitle;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.senderName,
    this.senderAvatar,
    required this.type,
    this.newsTitle,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'].toString(),
      senderName: json['sender_name'] ?? 'Someone',
      senderAvatar: json['sender_avatar'],
      type: json['type']??'',
      newsTitle: json['news_title'],
      isRead: json['is_read'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  String get actionText {
    switch (type) {
      case 'comment': return 'commented on your news';
      case 'follow':  return 'is now following you';
      case 'like':    return 'liked your news';
      default:        return 'interacted with you';
    }
  }

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24)   return '${diff.inHours}h ago';
    return '${diff.inDays} day ago';
  }
}