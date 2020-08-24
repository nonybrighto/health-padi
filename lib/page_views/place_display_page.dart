import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthpadi/models/place.dart';
import 'package:healthpadi/providers/place_list_model.dart';
import 'package:healthpadi/utilities/constants.dart';
import 'package:healthpadi/utilities/load_state.dart';
import 'package:healthpadi/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDisplayPage extends StatefulWidget {
  final Place place;
  PlaceDisplayPage({Key key, this.place}) : super(key: key);

  @override
  _PlaceDisplayPageState createState() => new _PlaceDisplayPageState();
}

class _PlaceDisplayPageState extends State<PlaceDisplayPage>
    with SingleTickerProviderStateMixin {
  Completer<GoogleMapController> _mapController;
  Place place;
  @override
  void initState() {
    super.initState();
    place = widget.place;
    Provider.of<PlaceListModel>(context, listen: false)
        .changeCurrentPlace(widget.place);
    Provider.of<PlaceListModel>(context, listen: false)
        .getCurrentPlaceDetails();
    Provider.of<PlaceListModel>(context, listen: false).getCurrentPosition();
    _mapController = Completer();
    Provider.of<PlaceListModel>(context, listen: false)
        .fetchCurrentPlaceRoute();
  }

  @override
  Widget build(BuildContext context) {
    PlaceListModel placeListModel = Provider.of<PlaceListModel>(context);
    LoadState placeDetailsLoadState = placeListModel.placeDetailsLoadState;
    Place currentPlace = placeListModel.currentPlace;
    List<LatLng> routeCordinates = placeListModel.routeCordinates;

    Set<Polyline> polylines;
    if (routeCordinates != null) {
      polylines = {};
      polylines.add(Polyline(
          polylineId: PolylineId('place'),
          visible: true,
          points: routeCordinates,
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    }
    return Scaffold(
        appBar: buildAppBar(title: currentPlace.name),
        body: ExpandableBottomSheet(
          background: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(currentPlace.geometry.location.lat,
                  currentPlace.geometry.location.lng),
              zoom: 12,
            ),
            polylines: polylines,
            markers: placeListModel.items
                .map((place) => Marker(
                      markerId: MarkerId(currentPlace.placeId),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          currentPlace.placeId == place.placeId ? 350 : 50),
                      position: LatLng(
                        currentPlace.geometry.location.lat,
                        currentPlace.geometry.location.lng,
                      ),
                      infoWindow: InfoWindow(
                        title: currentPlace.name,
                        snippet: currentPlace.vicinity,
                      ),
                    ))
                .toSet(),
            onMapCreated: (mapController) {
              _mapController.complete(mapController);
            },
          ),
          persistentHeader: _buildVisibleScrollContent(currentPlace),
          expandableContent:
              _buildHiddenScrollContent(placeDetailsLoadState, currentPlace),
        ));
  }

  _buildVisibleScrollContent(Place currentPlace) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey)],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            width: 40,
            height: 7,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: currentPlace.icon != null
                  ? NetworkImage(currentPlace.icon)
                  : null,
            ),
            title: AutoSizeText(
              currentPlace.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: AutoSizeText(
              currentPlace.vicinity,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: currentPlace.internationalPhoneNumber == null
                ? null
                : IconButton(
                    icon: Icon(
                      Icons.phone,
                      color: Colors.lightGreen,
                    ),
                    onPressed: () {
                      launch('tel:${currentPlace.internationalPhoneNumber}');
                    }),
          ),
          Container(
            // color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildCountItem(
                    Icons.star,
                    currentPlace.rating == null
                        ? 'X'
                        : currentPlace.rating.toString(),
                    'Rating'),
                _buildCountItem(
                    Icons.pie_chart,
                    currentPlace.distanceFromLocationInKm.toStringAsFixed(1) +
                        'KM',
                    'Distance'),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildHiddenScrollContent(
      LoadState placeDetailsLoadState, Place currentPlace) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            Divider(),
            if (placeDetailsLoadState is Loading)
              SpinKitThreeBounce(
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            if (placeDetailsLoadState is LoadError)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding),
                child: Text('Failed to load place details'),
              ),
            if (placeDetailsLoadState is Loaded)
              Column(
                children: <Widget>[
                  Text(
                    currentPlace.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildDetailItem(
                      'Types', currentPlace.getPlaceTypesAsString()),
                  _buildDetailItem('Address', currentPlace.vicinity),
                  _buildDetailItem('Phone',
                      currentPlace.internationalPhoneNumber ?? 'no number'),
                  _buildDetailItem(
                      'Website', currentPlace.website ?? 'no website')
                ],
              )
          ],
        ),
      ),
    );
  }

  _buildDetailItem(String title, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              title + ':',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(text))
        ],
      ),
    );
  }

  _buildCountItem(IconData icon, String countText, String title) {
    Color iconAndTitleColor = Colors.white.withOpacity(0.8);
    return Column(
      children: <Widget>[
        Icon(
          icon,
          color: iconAndTitleColor,
        ),
        Text(
          countText,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
        ),
        Text(
          title.toUpperCase(),
          style: TextStyle(color: iconAndTitleColor),
        )
      ],
    );
  }
}
