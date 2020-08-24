import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:healthpadi/models/place.dart';
import 'package:healthpadi/models/place_type.dart';
import 'package:healthpadi/providers/place_list_model.dart';
import 'package:healthpadi/utilities/constants.dart';
import 'package:healthpadi/widgets/views/scroll_list_view.dart';
import 'package:healthpadi/widgets/place_card.dart';
import 'package:permission_handler/permission_handler.dart';
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
                    {int index, Place item, Place previousItem}) =>
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
      child: Row(children: [
        for (PlaceType placeType in placeModel.placeTypes)
          Padding(
            padding: const EdgeInsets.all(1),
            child: ChoiceChip(
              selected: selectedPlaceType.name == placeType.name,
              label: Text(placeType.name),
              onSelected: (selected) {
                _fetchPlacForType(placeType);
              },
            ),
          ),
      ]),
    );
  }

  _fetchPlacForType(PlaceType placeType) {
    PlaceListModel factModel =
        Provider.of<PlaceListModel>(context, listen: false);
    factModel.changeSelectedPlaceType(placeType);
    factModel.fetchPlaces();
  }

  _initializeLocation() async {
    if (await Permission.location.request().isGranted) {
      if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
        Provider.of<PlaceListModel>(context, listen: false).fetchPlaces();
      } else {
        final AndroidIntent intent = new AndroidIntent(
          action: 'android.settings.LOCATION_SOURCE_SETTINGS',
        );

        await intent.launch();
      }
    }
  }
}
