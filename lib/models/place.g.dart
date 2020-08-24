// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place(
    placeId: json['place_id'] as String,
    icon: json['icon'] as String,
    name: json['name'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    vicinity: json['vicinity'] as String,
    distanceFromLocationInKm:
        (json['distanceFromLocationInKm'] as num)?.toDouble(),
    types: (json['types'] as List)?.map((e) => e as String)?.toList(),
    website: json['website'] as String,
    internationalPhoneNumber: json['international_phone_number'] as String,
    geometry: json['geometry'] == null
        ? null
        : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'place_id': instance.placeId,
      'icon': instance.icon,
      'name': instance.name,
      'rating': instance.rating,
      'vicinity': instance.vicinity,
      'distanceFromLocationInKm': instance.distanceFromLocationInKm,
      'types': instance.types,
      'website': instance.website,
      'international_phone_number': instance.internationalPhoneNumber,
      'geometry': instance.geometry,
    };
