import 'package:healthpadi/models/geometry.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {

  @JsonKey(name: 'place_id')
  String placeId;
  String icon;
  String name;
  double rating;
  String vicinity;
  double distanceFromLocationInKm;
  List<String> types;
  String website;
  @JsonKey(name: 'international_phone_number')
  String internationalPhoneNumber;
  Geometry geometry;
 
  Place({
    this.placeId,
    this.icon,
    this.name,
    this.rating,
    this.vicinity,
    this.distanceFromLocationInKm,
    this.types,
    this.website,
    this.internationalPhoneNumber,
    this.geometry
  });

  factory Place.fromJson(Map<String, dynamic> map) => _$PlaceFromJson(map);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  getPlaceTypesAsString(){

    List<String> healthTypes  = ['pharmacy', 'doctor', 'drugstore', 'pharmacy', 'hospital', 'dentist'];
    final filteredTypes =  this.types.where((type) => healthTypes.contains(type)).toList();
    return filteredTypes.isEmpty ? null : filteredTypes.join(', ');
  }
}
