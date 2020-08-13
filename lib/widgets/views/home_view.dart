import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthpadi/models/news.dart';
import 'package:healthpadi/page_views/news_page.dart';
import 'package:healthpadi/providers/home_model.dart';
import 'package:healthpadi/widgets/features_card.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildSlider(),
          _buildFeatures(),
        ],
      ),
    );
  }

  _buildSlider() {

   return Selector<HomeModel, List<News>>(builder: (context , homeNews, child ) => CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: homeNews
          .map((news) => Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  maxWidth: 500,
                  maxHeight: 500,
                ),
                child: Text(news.title),
              ))
          .toList(),
    ), selector: (_, homeModel) => homeModel.homeNews );
    // List<String> latestNews = ['hello', 'hi', 'all'];
    // return CarouselSlider(
    //   options: CarouselOptions(
    //     autoPlay: true,
    //     aspectRatio: 2.0,
    //     enlargeCenterPage: true,
    //   ),
    //   items: latestNews
    //       .map((e) => Container(
    //             color: Colors.grey,
    //             width: MediaQuery.of(context).size.width,
    //             constraints: BoxConstraints(
    //               maxWidth: 500,
    //               maxHeight: 500,
    //             ),
    //             child: Text(e),
    //           ))
    //       .toList(),
    // );
  }

  _buildFeatures() {
    
    return GridView(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 360 ? 4 : 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5),
      children: [
        FeaturesCard(
          title: 'News',
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewsPage())),
        ),
        FeaturesCard(
          title: 'News',
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewsPage())),
        ),
        FeaturesCard(
          title: 'News',
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewsPage())),
        ),
        FeaturesCard(
          title: 'News',
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewsPage())),
        )
      ],
    );
  }
}
