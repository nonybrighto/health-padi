import 'package:flutter/material.dart';
import 'package:healthpadi/models/news.dart';
import 'package:healthpadi/providers/news_list_model.dart';
import 'package:healthpadi/widgets/views/scroll_list_view.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('news'),),
      body: ScrollListView<NewsListModel, News>(
        viewModelBuilder: () => Provider.of<NewsListModel>(context),
        onLoad: () => Provider.of<NewsListModel>(context).fetchNews(),
        currentListItemWidget: (news, index) => Text("${news.title}"),
      ),
      // body: Text('ssss'),
    );
  }
}