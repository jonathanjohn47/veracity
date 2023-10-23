// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

List<ArticleModel> articleModelFromJson(String str) => List<ArticleModel>.from(
    json.decode(str).map((x) => ArticleModel.fromJson(x)));

String articleModelToJson(List<ArticleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArticleModel {
  String title;
  String content;
  String url;
  int timestamp;
  List<Category> category;
  PublisherName publisherName;
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
    List<Category>? category,
    PublisherName? publisherName,
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
        category: List<Category>.from(
            json["category"].map((x) => categoryValues.map[x]!)),
        publisherName: publisherNameValues.map[json["publisher_name"]]!,
        thumbnailImageUrl: json["thumbnail_image_url"] == "false"
            ? ""
            : json["thumbnail_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "url": url,
        "timestamp": timestamp,
        "category":
            List<dynamic>.from(category.map((x) => categoryValues.reverse[x])),
        "publisher_name": publisherNameValues.reverse[publisherName],
        "thumbnail_image_url": thumbnailImageUrl,
      };
}

enum Category {
  BUSINESS,
  EDIT_OPINION,
  EDUCATION,
  ENTERTAINMENT,
  E_PAPER,
  HEALTHCARE,
  INTERNATIONAL,
  JAMMU,
  KASHMIR,
  MORE,
  NATIONAL,
  POLITICS,
  SPORTS,
  TECHNOLOGY,
  UNCATEGORIZED
}

final categoryValues = EnumValues({
  "Business": Category.BUSINESS,
  "Edit/Opinion": Category.EDIT_OPINION,
  "Education": Category.EDUCATION,
  "Entertainment": Category.ENTERTAINMENT,
  "E-Paper": Category.E_PAPER,
  "Healthcare": Category.HEALTHCARE,
  "International": Category.INTERNATIONAL,
  "Jammu": Category.JAMMU,
  "Kashmir": Category.KASHMIR,
  "More": Category.MORE,
  "National": Category.NATIONAL,
  "Politics": Category.POLITICS,
  "Sports": Category.SPORTS,
  "Technology": Category.TECHNOLOGY,
  "Uncategorized": Category.UNCATEGORIZED
});

enum PublisherName { DAILY_VERACITY_NEWS }

final publisherNameValues =
    EnumValues({"Daily Veracity News": PublisherName.DAILY_VERACITY_NEWS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
