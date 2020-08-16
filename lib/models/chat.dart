import 'package:healthpadi/models/serializers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  String id;
  String content;
  String deviceIdentifier;
  @JsonKey(defaultValue: false)
  bool isBotMessage;
  @JsonKey(fromJson: timeStampToDateTime)
  DateTime createdAt;

  Chat({
    this.id,
    this.content,
    this.deviceIdentifier,
    this.isBotMessage,
    this.createdAt,
  });

  factory Chat.fromJson(Map<String, dynamic> map) => _$ChatFromJson(map);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
