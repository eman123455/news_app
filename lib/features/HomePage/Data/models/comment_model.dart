class Comment {
  final String id;
  final String postId;
  final String userId;
  final String content;
  final DateTime createdAt;

  const Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromMap(Map<String, dynamic> map) => Comment(
    id: map['id'],
    postId: map['post_id'],
    userId: map['user_id'],
    content: map['content'],
    createdAt: DateTime.parse(map['created_at']),
  );
}