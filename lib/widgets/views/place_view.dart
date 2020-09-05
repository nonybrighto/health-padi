// import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:healthpadi/models/place.dart';
import 'package:healthpadi/models/place_type.dart';
import 'package:healthpadi/providers/place_list_model.dart';
import 'package:healthpadi/utilities/constants.dart';
import 'package:healthpadi/widgets/views/scroll_list_view.dart';
import 'package:healthpadi/widgets/place_card.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class PlaceView extends StatefulWidget {
  @override
  _PlaceViewState createState() => _PlaceViewState();
}

class _PlaceViewState extends State<PlaceView> {
  @override
  void initState() {
    super.initState();
    _initializeLocation();
    Provider.of<PlaceListModel>(context, listen: false).fetchPlaceTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: <Widget>[
          _buildPlaceTypes(),
          Expanded(
              child: ScrollListView<PlaceListModel, Place>(
            loadOnInit: false,
            viewModelBuilder: () => Provider.of<PlaceListModel>(context),
            onLoad: () => Provider.of<PlaceListModel>(context, listen: false)
                .fetchPlaces(),
            currentListItemWidget: (
                    {int index, Place item, List<Place> allItems}) =>
                PlaceCard(place: item),
          ))
        ],
      ),
    );
  }

  _buildPlaceTypes() {
    final placeModel = Provider.of<PlaceListModel>(context);
    final selectedPlaceType = placeModel.selectedPlaceType;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: AnimationLimiter(
        child: Row(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 200.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              for (PlaceType placeType in placeModel.placeTypes)
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: ChoiceChip(
                    selected: selectedPlaceType.name == placeType.name,
                    label: Text(placeType.name),
                    onSelected: (selected) {
                      _fetchPlaceForType(placeType);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _fetchPlaceForType(PlaceType placeType) {
    PlaceListModel factModel =
        Provider.of<PlaceListModel>(context, listen: false);
    factModel.changeSelectedPlaceType(placeType);
    factModel.fetchPlaces();
  }

  _initializeLocation() async {
    Location location = new Location();
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted == PermissionStatus.granted) {
       await _checkServiceOn();
      }
    } else {
      await _checkServiceOn();
    }
  }

  _checkServiceOn() async {
    Location location = new Location();
    if (!(await location.serviceEnabled())) {
      bool enabled = await location.requestService();
      if (enabled) {
        Provider.of<PlaceListModel>(context, listen: false).fetchPlaces();
      }
    } else {
      Provider.of<PlaceListModel>(context, listen: false).fetchPlaces();
    }
  }
}
