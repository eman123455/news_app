import 'package:news_app/features/Explore/data/model/user_model.dart';

class CommentModel {
  int? id;
  String text;
  UserModel? user;

  CommentModel({
    required this.id,
    required this.text,
    this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      text: json['text'] ?? '',
      user: json['user'] != null
          ? UserModel.fromJson(json['user'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'user': user?.toJson(),
    };
  }
}