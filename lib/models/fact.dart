import 'package:healthpadi/models/fact_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fact.g.dart';

@JsonSerializable()
class Fact {
  int id;
  String content;
  String type;
  FactCategory category;
  DateTime createdAt;

  Fact({
    this.id,
    this.content,
    this.type,
    this.category,
    this.createdAt,
  });

  factory Fact.fromJson(Map<String, dynamic> map) => _$FactFromJson(map);
  Map<String, dynamic> toJson() => _$FactToJson(this);
}
