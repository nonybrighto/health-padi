import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthpadi/models/location.dart';
import 'package:healthpadi/models/place.dart';
import 'package:healthpadi/models/place_list_response.dart';
import 'package:healthpadi/models/place_type.dart';
import 'package:healthpadi/providers/scroll_list_model.dart';
import 'package:healthpadi/services/remote/place_remote.dart';
import 'package:healthpadi/utilities/load_state.dart';
import 'package:healthpadi/utilities/locator.dart';
import 'package:healthpadi/utilities/secret.dart';

class PlaceListModel extends ScrollListModel<Place> {
  String _nextPageToken;
  List<PlaceType> _placeTypes = [];
  PlaceType _selectedPlaceType;
  Position _currentPosition;
  Place _currentPlace;
  List<LatLng> _routeCordinates;
  LoadState _placeDetialsLoadState;

  PlaceRemote placeRemote = locator<PlaceRemote>();

  List<PlaceType> get placeTypes => _placeTypes;
  PlaceType get selectedPlaceType => _selectedPlaceType;
  Position get currentPosition => _currentPosition;
  Place get currentPlace => _currentPlace;
  List<LatLng> get routeCordinates => _routeCordinates;
  LoadState get placeDetailsLoadState => _placeDetialsLoadState;

  PlaceListModel() {
    emptyResultMessage = 'No place found';
    _selectedPlaceType = PlaceType(name: 'Hospital', value: 'hospital');
    _placeDetialsLoadState = Loading();
  }

  fetchPlaces() async {
    await fetchItems(() {
      return placeRemote.fetchPlaces(
          nextPageToken: _nextPageToken,
          type: _selectedPlaceType.value,
          radius: 2000);
    });
  }

  fetchPlaceTypes() async {
    _placeTypes = [
      PlaceType(name: 'Hospital', value: 'hospital'),
      PlaceType(name: 'Pharmacy', value: 'pharmacy'),
      PlaceType(name: 'Drugstore', value: 'drugstore'),
      PlaceType(name: 'Dentist', value: 'dentist'),
      PlaceType(name: 'Doctor', value: 'doctor'),
      PlaceType(name: 'Physiotherapist', value: 'physiotherapist'),
    ];
  }

  changeSelectedPlaceType(PlaceType selectedPlaceType) {
    currentPage = 1;
    forceLoad = true;
    _nextPageToken = null;
    setHasReachedMax(false);
    _selectedPlaceType = selectedPlaceType;
    notifyListeners();
  }

  changeCurrentPlace(Place place) {
    _currentPlace = place;
    notifyListeners();
  }

  fetchCurrentPlaceRoute() async {
    _routeCordinates = null;
    GoogleMapPolyline googleMapPolyline =
        new GoogleMapPolyline(apiKey: kPlacesApiKey);
    Location currentPlaceLocation = _currentPlace.geometry.location;
    List<LatLng> routeCordinates =
        await googleMapPolyline.getCoordinatesWithLocation(
            origin:
                LatLng(_currentPosition.latitude, _currentPosition.longitude),
            destination:
                LatLng(currentPlaceLocation.lat, currentPlaceLocation.lng),
            mode: RouteMode.driving);
    _routeCordinates = routeCordinates;
    notifyListeners();
  }

  @override
  fetchItems(Function serverCallback) async {
    if (canLoadMore()) {
      setLoadState(Loading(more: currentPage != 1));

      try {
        await getCurrentPosition();
        PlaceListResponse gottenResponse = await serverCallback();
        List<Place> gottenItems = gottenResponse.results.toList();
        gottenItems = await Future.wait(gottenItems
            .map((place) async => place
              ..distanceFromLocationInKm =
                  await _getDistanceFromCurrentLocation(
                      place.geometry.location))
            .toList());
        gottenItems = [...gottenItems];
        if (currentPage == 1) {
          setItems(gottenItems);
        } else {
          appendItems(gottenItems);
        }
        hasReachedMax = gottenResponse.nextPageToken == null;
        if (currentPage == 1 && gottenItems.isEmpty) {
          setLoadState(LoadedEmpty(emptyResultMessage));
        } else {
          setLoadState(Loaded(hasReachedMax: hasReachedMax));
        }
        _nextPageToken = gottenResponse.nextPageToken;
        currentPage++;
      } catch (error) {
        setLoadState(LoadError(
            message: error?.message ?? 'Error getting places',
            more: currentPage > 1));
      }
      forceLoad = false;
    }
  }

  _getDistanceFromCurrentLocation(Location placeLocation) async {
    if (_currentPosition == null) {
      return null;
    }
    return (await Geolocator().distanceBetween(_currentPosition.latitude,
            _currentPosition.longitude, placeLocation.lat, placeLocation.lng)) /
        1000;
  }

  getCurrentPosition() async {
    Position position = _currentPosition ??
        await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    position = position ??
        await Geolocator()
            .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    _currentPosition = position;
    // notifyListeners();
  }

  getCurrentPlaceDetails() async {
    try {
      _placeDetialsLoadState = Loading();
      Place place = await placeRemote.fetchPlaceDetails(_currentPlace.placeId);
      place.distanceFromLocationInKm =
          await _getDistanceFromCurrentLocation(place.geometry.location);
      _currentPlace = place;
      _placeDetialsLoadState = Loaded();
    } catch (error) {
      _placeDetialsLoadState = LoadError(message: 'failed to get place');
    }
    notifyListeners();
  }
}
