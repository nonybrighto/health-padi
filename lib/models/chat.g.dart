// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
    id: json['id'] as String,
    content: json['content'] as String,
    deviceIdentifier: json['deviceIdentifier'] as String,
    isBotMessage: json['isBotMessage'] as bool ?? false,
    createdAt: timeStampToDateTime(json['createdAt']),
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'deviceIdentifier': instance.deviceIdentifier,
      'isBotMessage': instance.isBotMessage,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
