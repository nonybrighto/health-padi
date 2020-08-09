import 'package:healthpadi/models/news.dart';
import 'package:healthpadi/providers/scroll_list_model.dart';
import 'package:healthpadi/services/remote/news_remote.dart';
import 'package:healthpadi/utilities/locator.dart';

class NewsListModel extends ScrollListModel<News> {


  NewsRemote newsRemote = locator<NewsRemote>();
    fetchNews() async{
     await fetchItems((){
            return newsRemote.fetchNews(page: currentPage);
      });
    }
}