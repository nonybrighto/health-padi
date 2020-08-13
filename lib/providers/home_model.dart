import 'package:flutter/material.dart';
import 'package:healthpadi/models/news.dart';
import 'package:healthpadi/services/remote/news_remote.dart';
import 'package:healthpadi/utilities/locator.dart';

class HomeModel extends ChangeNotifier {
  String _name = 'Initial';
  int _homeIndex = 2;
  String get name => _name;
  List<News> _homeNews = [];
  int get homeIndex => _homeIndex;
  List<News> get homeNews => _homeNews;

  NewsRemote newsRemote = locator<NewsRemote>();

  changeName(String name) {
    _name = name;
    notifyListeners();
  }

  changeHomeIndex(int index) {
    _homeIndex = index;
    notifyListeners();
  }

  getHomeNews() async {
    try {
      final homeNews = await newsRemote.fetchNews(page: 1);
      _homeNews = homeNews.results;
    } catch (error) {
      //log error
      print('error in fetching');
    }
    notifyListeners();
  }
}
