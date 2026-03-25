import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String? id;
  final String? username;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? bio;
  final dynamic website;
  final String? imageUrl;
  final String? country;
  final String? role;
  final DateTime? createdAt;

  const ProfileModel({
    this.id,
    this.username,
    this.fullName,
    this.email,
    this.phone,
    this.bio,
    this.website,
    this.imageUrl,
    this.country,
    this.role,
    this.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json['id'] as String?,
    username: json['username'] as String?,
    fullName: json['full_name'] as String?,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    bio: json['bio'] as String?,
    website: json['website'] as dynamic,
    imageUrl: json['image_url'] as String?,
    country: json['country'] as String?,
    role: json['role'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'full_name': fullName,
    'email': email,
    'phone': phone,
    'bio': bio,
    'website': website,
    'image_url': imageUrl,
    'country': country,
    'role': role,
    'created_at': createdAt?.toIso8601String(),
  };

  @override
  List<Object?> get props {
    return [
      id,
      username,
      fullName,
      email,
      phone,
      bio,
      website,
      imageUrl,
      country,
      role,
      createdAt,
    ];
  }
}
