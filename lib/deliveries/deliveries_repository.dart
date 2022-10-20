import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:suppwayy_mobile/suppwayy_config.dart';

import '../main_repository.dart';
import 'model/deliveries_list_model.dart';

class DeliveriesService extends MainRepository {
  Future<DeliveriesListModel> fetchDeliveries() async {
    Uri uri = Uri.parse(SuppWayy.getDeliveries);
    var response = await http.get(uri, headers: getHeadersWithAuthorization);
    if (response.statusCode == HttpStatus.ok) {
      var jsonResponse = json.decode(response.body);
      DeliveriesListModel deliveriesList =
          DeliveriesListModel.fromMap(jsonResponse);
      return deliveriesList;
    } else {
      throw Exception('Failed to load deliveries List');
    }
  }

  Future<bool> addDelivery(int saleId, Delivery delivery) async {
    Uri uri = Uri.parse(SuppWayy.postDeliveries(saleId));
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    String data = """{
            "state": "${delivery.state}",
             "date": "${delivery.date.toIso8601String()}",
            "signatureMethod": "${delivery.signatureMethod}",
            "signed": "${delivery.signed}"
        }""";
    var response = await http.post(uri, headers: headers, body: data);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      throw Exception('Failed to create delivery');
    }
  }

  Future<bool> deleteDelivery(int deliveryId) async {
    Uri uri = Uri.parse(SuppWayy.getDeliveries + '$deliveryId');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == HttpStatus.noContent) {
      return true;
    } else {
      throw Exception('Failed to delete delivery');
    }
  }

  Future<bool> patchDelivery(int deliveryId, Map deliveryStateUpdated) async {
    Uri uri = Uri.parse(SuppWayy.getDeliveries + '$deliveryId');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(deliveryStateUpdated));
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      throw Exception('Failed to update delivery');
    }
  }

  Future<bool> patchDeliveryLine(
      int deliveryId, int deliveryLineId, Map deliveryLineUpdated) async {
    Uri uri = Uri.parse(SuppWayy.getDeliveryLine(deliveryId, deliveryLineId));
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(deliveryLineUpdated));
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      throw Exception('Failed to update delivery');
    }
  }
}
