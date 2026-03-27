import 'package:supabase_flutter/supabase_flutter.dart';
import 'comment_model.dart';

class CommentsRepository {
  final _supabase = Supabase.instance.client;
  Future<void> addComment({
    required String postId,
    required String content,
    required String postOwnerId,
    required String newsTitle,
  }) async {
    final currentUserId = _supabase.auth.currentUser!.id;

    await _supabase.from('comments').insert({
      'post_id': postId,
      'user_id': currentUserId,
      'content': content,
    });

    if (currentUserId == postOwnerId) return;

    final profile = await _supabase
        .from('profiles')
        .select('name, avatar_url')
        .eq('id', currentUserId)
        .single();
    await _supabase.from('notifications').insert({
      'receiver_id': postOwnerId,
      'sender_id': currentUserId,
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