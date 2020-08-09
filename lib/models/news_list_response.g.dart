// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsListResponse _$NewsListResponseFromJson(Map<String, dynamic> json) {
  return NewsListResponse(
    currentPage: json['currentPage'] as int,
    nextPage: json['nextPage'] as int,
    perPage: json['perPage'] as int,
    previousPage: json['previousPage'] as int,
    totalPages: json['totalPages'] as int,
    results: (json['results'] as List)
        ?.map(
            (e) => e == null ? null : News.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NewsListResponseToJson(NewsListResponse instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'nextPage': instance.nextPage,
      'perPage': instance.perPage,
      'previousPage': instance.previousPage,
      'results': instance.results,
      'totalPages': instance.totalPages,
    };
