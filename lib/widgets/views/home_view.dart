import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthpadi/models/fact.dart';
import 'package:healthpadi/models/news.dart';
import 'package:healthpadi/providers/home_model.dart';
import 'package:healthpadi/utilities/constants.dart';
import 'package:healthpadi/widgets/fact_card.dart';
import 'package:healthpadi/widgets/features_card.dart';
import 'package:healthpadi/widgets/loading_indicator.dart';
import 'package:healthpadi/widgets/error_indicator.dart';
import 'package:healthpadi/widgets/home_news_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeModel>(context, listen: false).getHomeNews();
    Provider.of<HomeModel>(context, listen: false).getHomeFacts();
  }

  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of<HomeModel>(context);
    bool homeLoading = homeModel.homeLoading;
    bool homeHasError = homeModel.homeHasError;

    if (homeLoading) {
      return LoadingIndicator();
    } else if (homeHasError) {
      return Column(
        children: <Widget>[_buildFeatures(), Expanded(child: ErrorIndicator(errorMessage: 'Failed to load content' , onReload: (){
           Provider.of<HomeModel>(context, listen: false).getHomeNews();
           Provider.of<HomeModel>(context, listen: false).getHomeFacts();
        },))],
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildNewsSlider(homeModel.homeNews),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: <Widget>[
                _buildFeatures(),
                _buildHomeFacts(homeModel.homeFacts),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildNewsSlider(List<News> homeNews) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: homeNews.map((news) => HomeNewsCard(news: news)).toList(),
    );
  }

  _buildFeatures() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            FeaturesCard(
              title: 'Chat Bot',
              assetIconPath: 'assets/icons/menu.svg',
              onPressed: () =>
                Provider.of<HomeModel>(context, listen: false).changeHomeIndex(0)
              ),
            FeaturesCard(
              title: 'Places',
              assetIconPath: 'assets/icons/menu.svg',
              onPressed: () => Provider.of<HomeModel>(context, listen: false).changeHomeIndex(1),
            ),
            FeaturesCard(
              title: 'Facts',
              assetIconPath: 'assets/icons/menu.svg',
              onPressed: () => Provider.of<HomeModel>(context, listen: false).changeHomeIndex(3),
            ),
            FeaturesCard(
              title: 'News',
              assetIconPath: 'assets/icons/menu.svg',
              onPressed: () => Provider.of<HomeModel>(context, listen: false).changeHomeIndex(4),
            ),
            
          ],
        ),
      ),
    );
  }

  _buildHomeFacts(List<Fact> homeFacts) {
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: homeFacts.map((fact) => FactCard(fact: fact)).toList(),
    );
  }
}
