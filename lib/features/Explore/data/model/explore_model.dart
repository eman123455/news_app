import 'package:news_app/features/Explore/data/model/comment_model.dart';
import 'package:news_app/features/Explore/data/model/like_model.dart';
import 'package:news_app/features/Explore/data/model/user_model.dart';

class ExploreModel {
  int? id;
  String userId;
  String? sourceId;
  String title;
  String content;
  String imageUrl;
  int? categoryId;
  String country;
  DateTime createdAt;

  UserModel? user;
  List<LikeModel> likes;
  List<CommentModel> comments;

  ExploreModel({
    required this.id,
    required this.userId,
    required this.sourceId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.categoryId,
    required this.country,
    required this.createdAt,
    this.user,
    required this.likes,
    required this.comments,
  });

  factory ExploreModel.fromJson(Map<String, dynamic> json) {
    // print('User Json');
    // print(json['profile']);
    return ExploreModel(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      sourceId: json['source_id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String,
      categoryId: json['category_id'] as int,
      country: json['country'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),

      user: json['profile'] != null
          ? UserModel.fromJson(json['profile'])
          : null,

      likes: (json['likes'] as List?)
          ?.map((e) => LikeModel.fromJson(e))
          .toList() ??
          [],

      comments: (json['comments'] as List?)
          ?.map((e) => CommentModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'source_id': sourceId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'category_id': categoryId,
      'country': country,
      'created_at': createdAt.toIso8601String(),
      'profile': user?.toJson(),
      'likes': likes.map((e) => e.toJson()).toList(),
      'comments': comments.map((e) => e.toJson()).toList(),
    };
  }

  static List<ExploreModel> fromJsonList(List<dynamic> list) {
    return list
        .map((e) => ExploreModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}