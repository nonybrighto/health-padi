import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthpadi/models/place.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:healthpadi/page_views/place_display_page.dart';
import 'package:healthpadi/utilities/constants.dart';
import 'package:healthpadi/widgets/rating_star.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  PlaceCard({this.place});

  @override
  Widget build(BuildContext context) {
    double imageSize = 80;
    final subTextStyle = Theme.of(context)
        .textTheme
        .subtitle2
        .copyWith(color: kSubTextColor, fontWeight: FontWeight.normal);
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        place.name,
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                        minFontSize: 19,
                      ),
                      SizedBox(height: 3),
                      Text(
                        place?.vicinity ?? 'no address',
                        style: subTextStyle,
                      ),
                      SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RatingStar(rating: place?.rating ?? 0),
                          Text(
                            place.distanceFromLocationInKm != null
                                ? place.distanceFromLocationInKm
                                        .toStringAsFixed(1) +
                                    'KM'
                                : '',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: place.icon != null
                    ? CachedNetworkImage(
                        height: imageSize,
                        width: imageSize,
                        imageUrl: place.icon,
                        fit: BoxFit.cover,
                        fadeInDuration: Duration(milliseconds: 800),
                        placeholder: (context, url) =>
                            _buildPlaceHolder(imageSize),
                        errorWidget: (context, url, _) =>
                            _buildPlaceHolder(imageSize),
                      )
                    : _buildPlaceHolder(imageSize),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlaceDisplayPage(place: place)));
        },
      ),
    );
  }

  _buildPlaceHolder(double imageSize) {
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: Colors.grey[400]),
    );
  }
}
