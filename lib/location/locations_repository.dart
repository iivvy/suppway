import 'dart:convert';
import 'dart:io';

import 'package:suppwayy_mobile/location/models/location_list_model.dart';
import 'package:suppwayy_mobile/main_repository.dart';
import 'package:suppwayy_mobile/suppwayy_config.dart';

import 'package:http/http.dart' as http;

abstract class LocationsListRepository extends MainRepository {
  Future<LocationListModel> fetchLocations();
}

class LocationsListAPI extends LocationsListRepository {
  MainRepository mainRepository = MainRepository();

  @override

  ///send request Get all Location
  Future<LocationListModel> fetchLocations() async {
    Uri uri = Uri.parse(SuppWayy.getLocations);
    var response = await http.get(uri, headers: getHeadersWithAuthorization);

    if (response.statusCode == HttpStatus.ok) {
      final String rawLocationsList = response.body.toString();

      return LocationListModel.fromJson(rawLocationsList);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load locations ');
    }
  }

  /// Send request Get location filter with position of user
  Future<LocationListModel> fetchLocationsByPosition(
      double lat, double lng) async {
    final queryParameters = {'lat': lat.toString(), 'lon': lng.toString()};
    Uri uri = Uri.parse(SuppWayy.getLocations)
        .replace(queryParameters: queryParameters);
    var response = await http.get(uri, headers: getHeadersWithAuthorization);
    if (response.statusCode == HttpStatus.ok) {
      final String rawLocationsList = response.body;
      return LocationListModel.fromJson(rawLocationsList);
    } else {
      throw Exception('Failed to load locations ');
    }
  }

  Future<bool> addLocation(Location location) async {
    Uri uri = Uri.parse(SuppWayy.getLocations);
    String data = """{
            "name": "${location.name}",
            "gln": "${location.gln}",
            "number": ${location.number},
            "street": "${location.street}",
            "postalcode": "${location.postalcode}",
            "city": "${location.city}",
            "country": "${location.country}",
            "lat": ${location.lat},
            "lon": ${location.lon}
        }""";
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";

    var response = await http.post(uri, headers: headers, body: data);
    if (response.statusCode == HttpStatus.created) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteLocation(int locationId) async {
    Uri uri = Uri.parse(SuppWayy.getLocations + '$locationId');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == HttpStatus.noContent) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateLocation(int locationId, Map updatedLocation) async {
    Uri uri = Uri.parse(SuppWayy.getLocations + '$locationId');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(updatedLocation));
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }
}
