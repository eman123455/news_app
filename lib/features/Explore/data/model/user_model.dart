class UserModel {
  String? id;
  String name;
  String? image;

  UserModel({
    required this.id,
    required this.name,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print('User Json');
    print(json);
    return UserModel(
      id: json['id'].toString(),
      name: json['username'] ?? '',
      image: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': image,
    };
  }
}