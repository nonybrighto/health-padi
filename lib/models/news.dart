import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  int id;
  String title;
  String host;
  String sourceUrl;
  String imageUrl;
  DateTime createdAt;

  News({
    this.id,
    this.title,
    this.host,
    this.sourceUrl,
    this.imageUrl,
    this.createdAt,
  });

  factory News.fromJson(Map<String, dynamic> map) => _$NewsFromJson(map);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}
