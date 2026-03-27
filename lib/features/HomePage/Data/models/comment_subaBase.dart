import 'package:supabase_flutter/supabase_flutter.dart';

import 'comment_model.dart';

class CommentsRepository {
  final _supabase = Supabase.instance.client;

  Future<void> addComment({
    required String postId,
    required String content,
  }) async {
    await _supabase.from('comments').insert({
      'post_id': postId,
      'user_id': _supabase.auth.currentUser!.id,
      'content': content,
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
