import 'package:flutter/material.dart';
import 'package:healthpadi/models/news.dart';
import 'package:healthpadi/providers/news_list_model.dart';
import 'package:healthpadi/widgets/news_card.dart';
import 'package:healthpadi/widgets/views/scroll_list_view.dart';
import 'package:provider/provider.dart';

class NewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollListView<NewsListModel, News>(
      viewModelBuilder: () => Provider.of<NewsListModel>(context),
      onLoad: () =>
          Provider.of<NewsListModel>(context, listen: false).fetchNews(),
      currentListItemWidget: ({int index, News item, News previousItem}) =>
          NewsCard(news: item),
    );
  }
}
