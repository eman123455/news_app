import 'package:news_app/features/HomePage/Data/models/results.dart';

class NewsModel {
  String? status;
  int? totalResults;
  List<Results>? results;
  String? nextPage;

  NewsModel({this.status, this.totalResults, this.results, this.nextPage});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      nextPage: json['nextPage'],
      results: json['results'] != null
          ? (json['results'] as List)
          .map((v) => Results.fromJson(v))
          .toList()
          : null,
    );
  }
}