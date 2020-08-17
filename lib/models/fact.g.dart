// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fact _$FactFromJson(Map<String, dynamic> json) {
  return Fact(
    id: json['id'] as int,
    content: json['content'] as String,
    type: json['type'] as String,
    category: json['category'] == null
        ? null
        : FactCategory.fromJson(json['category'] as Map<String, dynamic>),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$FactToJson(Fact instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'type': instance.type,
      'category': instance.category,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
