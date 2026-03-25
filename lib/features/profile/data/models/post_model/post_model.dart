import 'package:equatable/equatable.dart';

import 'categories.dart';

class PostModel extends Equatable {
  final int? id;
  final String? userId;
  final dynamic sourceId;
  final String? title;
  final String? content;
  final String? imageUrl;
  final int? categoryId;
  final String? country;
  final DateTime? createdAt;
  final Categories? categories;

  const PostModel({
    this.id,
    this.userId,
    this.sourceId,
    this.title,
    this.content,
    this.imageUrl,
    this.categoryId,
    this.country,
    this.createdAt,
    this.categories,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'] as int?,
    userId: json['user_id'] as String?,
    sourceId: json['source_id'] as dynamic,
    title: json['title'] as String?,
    content: json['content'] as String?,
    imageUrl: json['image_url'] as String?,
    categoryId: json['category_id'] as int?,
    country: json['country'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String).toLocal(),
    categories: json['categories'] == null
        ? null
        : Categories.fromJson(json['categories'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'source_id': sourceId,
    'title': title,
    'content': content,
    'image_url': imageUrl,
    'category_id': categoryId,
    'country': country,
    'created_at': createdAt?.toIso8601String(),
    'categories': categories?.toJson(),
  };

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      sourceId,
      title,
      content,
      imageUrl,
      categoryId,
      country,
      createdAt,
      categories,
    ];
  }
}
