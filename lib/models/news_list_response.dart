import 'package:healthpadi/models/news.dart';
import 'package:healthpadi/models/list_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_list_response.g.dart';

@JsonSerializable()
class NewsListResponse implements ListResponse<News>{
  
  int currentPage;
  int nextPage;
  int perPage;
  int previousPage;
  List<News> results;
  int totalPages;
 
  NewsListResponse({this.currentPage, this.nextPage, this.perPage, this.previousPage, this.totalPages, this.results});

  factory NewsListResponse.fromJson(Map<String, dynamic> map) => _$NewsListResponseFromJson(map);
  Map<String, dynamic> toJson() => _$NewsListResponseToJson(this);

}