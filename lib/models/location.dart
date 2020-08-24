import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {

 
  double lat;
  double lng;
  Location({
    this.lat,
    this.lng
  });

  factory Location.fromJson(Map<String, dynamic> map) => _$LocationFromJson(map);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}