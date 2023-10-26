// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

List<ArticleModel> articleModelFromJson(String str) => List<ArticleModel>.from(json.decode(str).map((x) => ArticleModel.fromJson(x)));

String articleModelToJson(List<ArticleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArticleModel {
  String title;
  String content;
  String url;
  int timestamp;
  List<String> category;
  String publisherName;
  String thumbnailImageUrl;

  ArticleModel({
    required this.title,
    required this.content,
    required this.url,
    required this.timestamp,
    required this.category,
    required this.publisherName,
    required this.thumbnailImageUrl,
  });

  ArticleModel copyWith({
    String? title,
    String? content,
    String? url,
    int? timestamp,
    List<String>? category,
    String? publisherName,
    String? thumbnailImageUrl,
  }) =>
      ArticleModel(
        title: title ?? this.title,
        content: content ?? this.content,
        url: url ?? this.url,
        timestamp: timestamp ?? this.timestamp,
        category: category ?? this.category,
        publisherName: publisherName ?? this.publisherName,
        thumbnailImageUrl: thumbnailImageUrl ?? this.thumbnailImageUrl,
      );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    title: json["title"],
    content: json["content"],
    url: json["url"],
    timestamp: json["timestamp"],
    category: List<String>.from(json["category"].map((x) => x)),
    publisherName: json["publisher_name"],
    thumbnailImageUrl: json["thumbnail_image_url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "url": url,
    "timestamp": timestamp,
    "category": List<dynamic>.from(category.map((x) => x)),
    "publisher_name": publisherName,
    "thumbnail_image_url": thumbnailImageUrl,
  };
}
