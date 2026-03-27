import 'package:news_app/features/Explore/data/model/user_model.dart';

class CommentModel {
  int? id;
  String content;
  UserModel? user;
  int? parentId;
  List<CommentModel> replies;

  CommentModel({
    required this.id,
    required this.content,
    this.user,
    this.parentId,
    this.replies = const [],
  });

  CommentModel copyWith({List<CommentModel>? replies}) {
    return CommentModel(
      id: id,
      content: content,
      user: user,
      parentId: parentId,
      replies: replies ?? this.replies,
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      content: json['content'] ?? '',
      parentId: json['parent_id'],
      user: json['profile'] != null
          ? UserModel.fromJson(json['profile'])
          : null,
      replies: (json['replies'] as List?)
          ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'parent_id': parentId,
      'profile': user?.toJson(),
      'replies': replies.map((e) => e.toJson()).toList(),
    };
  }
}