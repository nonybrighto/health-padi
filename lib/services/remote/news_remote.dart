import 'package:healthpadi/models/news.dart';
import 'package:healthpadi/models/news_list_response.dart';

class NewsRemote {

  fetchNews({int page}) async {
      return NewsListResponse(
        currentPage: 1,
        perPage: 10,
        totalPages: 1,
        results: [
          News(id: 1, title: 'hello', source: 'hello'),
          News(id: 2, title: 'hello2', source: 'hello'),
          News(id: 3, title: 'hello3', source: 'hello'),
          News(id: 4, title: 'hello4', source: 'hello')
        ]
      );
  }
}