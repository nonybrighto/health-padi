import 'package:flutter/material.dart';
import 'package:healthpadi/models/fact.dart';
import 'package:healthpadi/models/news.dart';
import 'package:healthpadi/services/remote/fact_remote.dart';
import 'package:healthpadi/services/remote/news_remote.dart';
import 'package:healthpadi/utilities/constants.dart';
import 'package:healthpadi/utilities/load_state.dart';
import 'package:healthpadi/utilities/locator.dart';

class HomeModel extends ChangeNotifier {
  String _title = kAppName;
  int _homeIndex = 2;
  String get title => _title;
  List<News> _homeNews = [];
  List<Fact> _homeFacts = [];
  LoadState _newsLoadState = Loading();
  LoadState _factsLoadState = Loading();

  int get homeIndex => _homeIndex;
  List<News> get homeNews => (_homeNews..shuffle()).take(10).toList();
  List<Fact> get homeFacts => (_homeFacts..shuffle()).take(5).toList();
  bool get homeLoading =>
      _newsLoadState is Loading || _factsLoadState is Loading;
  bool get homeHasError =>
      _newsLoadState is LoadError || _factsLoadState is LoadError;

  NewsRemote newsRemote = locator<NewsRemote>();
  FactRemote factRemote = locator<FactRemote>();

  changeHomeIndex(int index) {
    _homeIndex = index;
    _title = _getPageTitle(index);
    notifyListeners();
  }

  getHomeNews() async {
    try {
      if (_homeNews.isEmpty) {
        _newsLoadState = Loading();
        final homeNews = await newsRemote.fetchNews(page: 1);
        _homeNews = homeNews.results;
        _newsLoadState = Loaded();
      }
    } catch (error) {
      _newsLoadState = LoadError();
    }
    notifyListeners();
  }

  getHomeFacts() async {
    try {
      if (_homeFacts.isEmpty) {
        _factsLoadState = Loading();
        final homeFacts = await factRemote.fetchRandomFacts();
        _homeFacts = homeFacts.results;
        _factsLoadState = Loaded();
      }
    } catch (error) {
      _factsLoadState = LoadError();
      print('error in fetching');
    }
    notifyListeners();
  }

  _getPageTitle(int index) {
    List pageTitles = [
      'ChatBot',
      'Places',
      kAppName,
      'Facts & Tips',
      'Health News'
    ];
    return pageTitles[index];
  }
}
