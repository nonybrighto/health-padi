import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthpadi/models/news.dart';

class HomeNewsCard extends StatelessWidget {
  final News news;
  HomeNewsCard({this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.darken),
            image: AssetImage('assets/images/news_placeholder.jpg'),
          )),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.darken),
              image: CachedNetworkImageProvider(news.imageUrl),
            )),
        padding: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    news.title,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  _buildHostDisplay(context, news.host)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildHostDisplay(BuildContext context, String host) {
    return Container(
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        margin: EdgeInsets.only(top: 5),
        child: Text(
          host,
          style: TextStyle(color: Colors.white),
        ));
  }
}