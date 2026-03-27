import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  final int? id;
  final String? name;
  final String? imageUrl;
  final DateTime? createdAt;
  final String? description;

  const Categories({
    this.id,
    this.name,
    this.imageUrl,
    this.createdAt,
    this.description,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json['id'] as int?,
    name: json['name'] as String?,
    imageUrl: json['image_url'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    description: json['description'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_url': imageUrl,
    'created_at': createdAt?.toIso8601String(),
    'description': description,
  };

  @override
  List<Object?> get props => [id, name, imageUrl, createdAt, description];
}
