import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Data/models/comment_model.dart';

class CommentsRepository {
  final _supabase = Supabase.instance.client;

  Future<void> addComment({
    required String postId,
    required String content,
    required String postOwnerId,
    required String newsTitle,
  }) async {
    await _supabase.from('comments').insert({
      'post_id': postId,
      'user_id': _supabase.auth.currentUser!.id,
      'content': content,
    });
    await _sendCommentNotification(
      receiverId: postOwnerId,
      newsTitle: newsTitle,
    );
  }

  Future<void> _sendCommentNotification({
    required String receiverId,
    required String newsTitle,
  }) async {
    final currentUser = _supabase.auth.currentUser!;

    if (currentUser.id == receiverId) return;
    final profile = await _supabase
        .from('profiles')
        .select('name, avatar_url')
        .eq('id', currentUser.id)
        .single();

    await _supabase.from('notifications').insert({
      'user_id': receiverId,
      'sender_id': currentUser.id,
      'sender_name': profile['name'] ?? 'Someone',
      'sender_avatar': profile['avatar_url'],
      'type': 'comment',
      'news_title': newsTitle,
    });
  }

  Stream<List<Comment>> watchComments(String postId) {
    return _supabase
        .from('comments')
        .stream(primaryKey: ['id'])
        .eq('post_id', postId)
        .order('created_at')
        .map((rows) => rows.map(Comment.fromMap).toList());
  }
}