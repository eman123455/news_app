import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final DateTime? createdAt;

  const CategoryModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    imageUrl: json['image_url'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'image_url': imageUrl,
    'created_at': createdAt?.toIso8601String(),
  };

  @override
  List<Object?> get props => [id, name, description, imageUrl, createdAt];
}
