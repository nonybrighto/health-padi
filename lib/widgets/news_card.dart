import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthpadi/page_views/news_display_page.dart';
import 'package:healthpadi/utilities/time_ago_messages.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:healthpadi/models/news.dart';
import 'package:healthpadi/utilities/constants.dart';

class NewsCard extends StatelessWidget {
  final News news;
  NewsCard({this.news});

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', TimeAgoMessages());
    double imageSize = 80;
    final subTextStyle = Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.grey[500], fontWeight: FontWeight.normal);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SizedBox(
                      height: imageSize,
                                          child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AutoSizeText(
                            news.title,
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                            minFontSize: 19,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(news.host, style: subTextStyle,),
                              Text(timeago.format(news.createdAt.subtract(Duration(minutes: 5))), style: subTextStyle,)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                                  child: news.imageUrl != null ? CachedNetworkImage(
                    height: imageSize,
                    width: imageSize,
                    imageUrl: news.imageUrl,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 800),
                    placeholder: (context, url) => _buildPlaceHolder(imageSize),
                    errorWidget: (context, url, _) =>
                        _buildPlaceHolder(imageSize),
                  ) : _buildPlaceHolder(imageSize),
                )
              ],
            ),
            onTap: () {
              Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewsDisplayPage(news: news,)));
            },
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  _buildPlaceHolder(double imageSize) {
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color:  Colors.grey[400]),
    );
  }
}
