import 'package:json_annotation/json_annotation.dart';

part 'fact_category.g.dart';

@JsonSerializable()
class FactCategory {
  int id;
  String name;
  int factCount;

  FactCategory({
    this.id,
    this.name,
    this.factCount
  });

  factory FactCategory.fromJson(Map<String, dynamic> map) => _$FactCategoryFromJson(map);
  Map<String, dynamic> toJson() => _$FactCategoryToJson(this);
}
