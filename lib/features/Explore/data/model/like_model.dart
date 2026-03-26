class LikeModel {
  int? id;
  String? userId;

  LikeModel({
    required this.id,
    this.userId,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['id'],
      userId: json['user_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
    };
  }
}