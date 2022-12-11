// To parse this JSON data, do
//
//     final everything = everythingFromJson(jsonString);

import 'dart:convert';

Everything everythingFromJson(String str) => Everything.fromJson(json.decode(str));

String everythingToJson(Everything data) => json.encode(data.toJson());

class Everything {
  Everything({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory Everything.fromJson(Map<String, dynamic> json) => Everything(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class Article {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: Source.fromJson(json["source"]),
    author: json["author"]??"",
    title: json["title"]??"",
    description: json["description"]??"",
    url: json["url"]??"",
    urlToImage: json["urlToImage"]??"",
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"]??"",
  );

  Map<String, dynamic> toJson() => {
    "source": source.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt.toIso8601String(),
    "content": content,
  };
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"]??"",
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

enum Id { THE_VERGE, CNN, WIRED, REUTERS, BUSINESS_INSIDER, BBC_NEWS, TIME, THE_NEXT_WEB }

final idValues = EnumValues({
  "bbc-news": Id.BBC_NEWS,
  "business-insider": Id.BUSINESS_INSIDER,
  "cnn": Id.CNN,
  "reuters": Id.REUTERS,
  "the-next-web": Id.THE_NEXT_WEB,
  "the-verge": Id.THE_VERGE,
  "time": Id.TIME,
  "wired": Id.WIRED
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
