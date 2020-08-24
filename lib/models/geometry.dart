import 'package:healthpadi/models/location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geometry.g.dart';

@JsonSerializable()
class Geometry {

 
  Location location;
  Geometry({
    this.location
  });

  factory Geometry.fromJson(Map<String, dynamic> map) => _$GeometryFromJson(map);
  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}
