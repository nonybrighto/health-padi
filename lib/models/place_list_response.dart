import 'package:healthpadi/models/place.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_list_response.g.dart';

@JsonSerializable()
class PlaceListResponse{
  
  @JsonKey(name:'next_page_token')
  String nextPageToken;
  List<Place> results;
 
  PlaceListResponse({this.nextPageToken, this.results});

  factory PlaceListResponse.fromJson(Map<String, dynamic> map) => _$PlaceListResponseFromJson(map);
  Map<String, dynamic> toJson() => _$PlaceListResponseToJson(this);

}