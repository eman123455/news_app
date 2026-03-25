class Results {
  String? articleId;
  String? link;
  String? title;
  String? description;
  String? content;
  List<String>? keywords;
  List<String>? creator;
  String? language;
  List<String>? country;
  List<String>? category;
  String? datatype;
  String? pubDate;
  String? pubDateTZ;
  String? fetchedAt;
  String? imageUrl;
  String? videoUrl;
  String? sourceId;
  String? sourceName;
  int? sourcePriority;
  String? sourceUrl;
  String? sourceIcon;
  String? sentiment;
  String? sentimentStats;
  String? aiTag;
  String? aiRegion;
  String? aiOrg;
  String? aiSummary;
  bool? duplicate;

  Results({
    this.articleId,
    this.link,
    this.title,
    this.description,
    this.content,
    this.keywords,
    this.creator,
    this.language,
    this.country,
    this.category,
    this.datatype,
    this.pubDate,
    this.pubDateTZ,
    this.fetchedAt,
    this.imageUrl,
    this.videoUrl,
    this.sourceId,
    this.sourceName,
    this.sourcePriority,
    this.sourceUrl,
    this.sourceIcon,
    this.sentiment,
    this.sentimentStats,
    this.aiTag,
    this.aiRegion,
    this.aiOrg,
    this.aiSummary,
    this.duplicate,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      articleId: json['article_id'],
      link: json['link'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      // ✅ كل List بتتحقق من الـ null الأول
      keywords: json['keywords'] != null
          ? List<String>.from(json['keywords'])
          : null,
      creator: json['creator'] != null
          ? List<String>.from(json['creator'])
          : null,
      language: json['language'],
      country: json['country'] != null
          ? List<String>.from(json['country'])
          : null,
      category: json['category'] != null
          ? List<String>.from(json['category'])
          : null,
      datatype: json['datatype'],
      pubDate: json['pubDate'],
      pubDateTZ: json['pubDateTZ'],
      fetchedAt: json['fetched_at'],
      imageUrl: json['image_url'],
      videoUrl: json['video_url'],
      sourceId: json['source_id'],
      sourceName: json['source_name'],
      sourcePriority: json['source_priority'],
      sourceUrl: json['source_url'],
      sourceIcon: json['source_icon'],
      sentiment: json['sentiment'],
      sentimentStats: json['sentiment_stats'],
      aiTag: json['ai_tag'],
      aiRegion: json['ai_region'],
      aiOrg: json['ai_org'],
      aiSummary: json['ai_summary'],
      duplicate: json['duplicate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'link': link,
      'title': title,
      'description': description,
      'content': content,
      'keywords': keywords,
      'creator': creator,
      'language': language,
      'country': country,
      'category': category,
      'datatype': datatype,
      'pubDate': pubDate,
      'pubDateTZ': pubDateTZ,
      'fetched_at': fetchedAt,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'source_id': sourceId,
      'source_name': sourceName,
      'source_priority': sourcePriority,
      'source_url': sourceUrl,
      'source_icon': sourceIcon,
      'sentiment': sentiment,
      'sentiment_stats': sentimentStats,
      'ai_tag': aiTag,
      'ai_region': aiRegion,
      'ai_org': aiOrg,
      'ai_summary': aiSummary,
      'duplicate': duplicate,
    };
  }
}