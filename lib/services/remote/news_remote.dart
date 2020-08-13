import 'package:dio/dio.dart';
import 'package:healthpadi/models/news_list_response.dart';
import 'package:healthpadi/utilities/connections.dart';

class NewsRemote {
  Future<NewsListResponse> fetchNews({int page = 1}) async {

    try {
      Response newsListResponse =
          await (await baseDio()).get('/news?page=$page');
      return NewsListResponse.fromJson(newsListResponse.data);
    } catch (error) {
      return handleError(error: error, message: 'getting news');
    }
  }
}
