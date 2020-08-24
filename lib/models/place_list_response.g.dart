// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceListResponse _$PlaceListResponseFromJson(Map<String, dynamic> json) {
  return PlaceListResponse(
    nextPageToken: json['next_page_token'] as String,
    results: (json['results'] as List)
        ?.map(
            (e) => e == null ? null : Place.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlaceListResponseToJson(PlaceListResponse instance) =>
    <String, dynamic>{
      'next_page_token': instance.nextPageToken,
      'results': instance.results,
    };
