import 'dart:convert';
import 'dart:io';

import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/main_repository.dart';
import 'package:suppwayy_mobile/suppwayy_config.dart';

import 'package:http/http.dart' as http;

class LotsService extends MainRepository {
  Future<LotListModel> fetchLots(int productId) async {
    Uri uri = Uri.parse(SuppWayy.getLotUrl(productId));
    var response = await http.get(uri, headers: getHeadersWithAuthorization);

    if (response.statusCode == HttpStatus.ok) {
      final String rawLotsList = response.body.toString();
      return LotListModel.fromJson(rawLotsList);
    } else {
      throw Exception('Failed to load lots ');
    }
  }

  Future<bool> addLot(int productID, Lot lot) async {
    Uri uri = Uri.parse(SuppWayy.getLotUrl(productID));
    String data = """{
            "reference": "${lot.reference}",
            "date": "${lot.date.toIso8601String()}",
            "quantity": ${lot.quantity},
            "location": {"id": ${lot.location.id}}
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

  Future<bool> patchLot(int productID, int lotID, Map updatedlotData) async {
    Uri uri = Uri.parse(SuppWayy.getLotUrl(productID) + '/$lotID');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(updatedlotData));
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteLot(int productId, int lotId) async {
    Uri uri = Uri.parse(SuppWayy.deleteLot(productId, lotId));
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == HttpStatus.noContent) {
      return true;
    } else {
      return false;
    }
  }
}
