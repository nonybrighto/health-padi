import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News{

  int id;
  String title;
  String source;

  News({
    this.id,
    this.title,
   this.source
  });

 factory News.fromJson(Map<String, dynamic> map) => _$NewsFromJson(map);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}