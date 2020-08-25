import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healthpadi/models/place.dart';
import 'package:healthpadi/models/place_list_response.dart';
import 'package:healthpadi/utilities/connections.dart';
import 'package:healthpadi/utilities/secret.dart';

class PlaceRemote {
  Map<String, Place> _placeDetailsCache =
      {}; // store full details here when retrieved

  Future<PlaceListResponse> fetchPlaces(
      {String nextPageToken, String type, int radius = 2000}) async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      String locationQueryString = position == null
          ? ''
          : '&location=${position.latitude},${position.longitude}';
      String nextPageQueryString =
          nextPageToken == null ? '' : '&pagetoken=$nextPageToken';

      Dio dio = Dio();

      Response response = await dio.get(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=$kPlacesApiKey&type=$type$locationQueryString&radius=$radius$nextPageQueryString');
      return PlaceListResponse.fromJson(response.data);
    } catch (error) {
      return handleError(error: error, message: 'getting places');
    }
  }

  Future<Place> fetchPlaceDetails(String placeId) async {
    try {
      if (_placeDetailsCache.containsKey(placeId)) {
        return _placeDetailsCache[placeId];
      }

      Dio dio = Dio();
      Response response = await dio.get(
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$kPlacesApiKey');
      Place place = Place.fromJson(response.data['result']);
      _placeDetailsCache[placeId] = place;
      return place;
    } catch (error) {
      return handleError(error: error, message: 'getting place details');
    }
  }
}
