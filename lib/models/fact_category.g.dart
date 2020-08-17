// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fact_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FactCategory _$FactCategoryFromJson(Map<String, dynamic> json) {
  return FactCategory(
    id: json['id'] as int,
    name: json['name'] as String,
    factCount: json['factCount'] as int,
  );
}

Map<String, dynamic> _$FactCategoryToJson(FactCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'factCount': instance.factCount,
    };
