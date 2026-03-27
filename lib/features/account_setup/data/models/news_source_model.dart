class NewsSourceModel {
  final String id;
  final String name;
  final String category;
  final String? description;
  final String? url;

  const NewsSourceModel({
    required this.id,
    required this.name,
    required this.category,
    this.description,
    this.url,
  });

  factory NewsSourceModel.fromJson(Map<String, dynamic> json) {
    return NewsSourceModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? 'general',
      description: json['description'] as String?,
      url: json['url'] as String?,
    );
  }
}
