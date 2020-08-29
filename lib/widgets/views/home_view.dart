import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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

    Future.microtask(() {
      Provider.of<HomeModel>(context, listen: false).getHomeNews();
      Provider.of<HomeModel>(context, listen: false).getHomeFacts();
    });
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
        children: <Widget>[
          _buildFeatures(),
          Expanded(
              child: ErrorIndicator(
            errorMessage: 'Failed to load content',
            onRetry: () {
              Provider.of<HomeModel>(context, listen: false).getHomeNews();
              Provider.of<HomeModel>(context, listen: false).getHomeFacts();
            },
          ))
        ],
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
        child: AnimationLimiter(
          child: Row(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 300.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
            FeaturesCard(
                title: 'Chat Bot',
                iconName: 'chat',
                onPressed: () => Provider.of<HomeModel>(context, listen: false)
                    .changeHomeIndex(0)),
            FeaturesCard(
              title: 'Places',
              iconName: 'place',
              onPressed: () => Provider.of<HomeModel>(context, listen: false)
                  .changeHomeIndex(1),
            ),
            FeaturesCard(
              title: 'Facts',
              iconName: 'fact',
              onPressed: () => Provider.of<HomeModel>(context, listen: false)
                  .changeHomeIndex(3),
            ),
            FeaturesCard(
              title: 'News',
              iconName: 'news',
              onPressed: () => Provider.of<HomeModel>(context, listen: false)
                  .changeHomeIndex(4),
            ),
          ],
            ),
          ),
        ),
      );
    // return SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 10),
    //     child: Row(
    //       children: <Widget>[
    //         FeaturesCard(
    //             title: 'Chat Bot',
    //             iconName: 'chat',
    //             onPressed: () => Provider.of<HomeModel>(context, listen: false)
    //                 .changeHomeIndex(0)),
    //         FeaturesCard(
    //           title: 'Places',
    //           iconName: 'place',
    //           onPressed: () => Provider.of<HomeModel>(context, listen: false)
    //               .changeHomeIndex(1),
    //         ),
    //         FeaturesCard(
    //           title: 'Facts',
    //           iconName: 'fact',
    //           onPressed: () => Provider.of<HomeModel>(context, listen: false)
    //               .changeHomeIndex(3),
    //         ),
    //         FeaturesCard(
    //           title: 'News',
    //           iconName: 'news',
    //           onPressed: () => Provider.of<HomeModel>(context, listen: false)
    //               .changeHomeIndex(4),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  _buildHomeFacts(List<Fact> homeFacts) {
    // return ListView(
    //   shrinkWrap: true,
    //   physics: ScrollPhysics(),
    //   children: homeFacts.map((fact) => ).toList(),
    // );
    return AnimationLimiter(
      child: ListView.builder(
         shrinkWrap: true,
      physics: ScrollPhysics(),
        itemCount: homeFacts.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: FactCard(fact: homeFacts[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
