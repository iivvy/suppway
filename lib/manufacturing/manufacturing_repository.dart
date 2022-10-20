import 'dart:convert';

import 'package:suppwayy_mobile/main_repository.dart';
import 'package:suppwayy_mobile/manufacturing/models/line_data.dart';
import 'package:suppwayy_mobile/manufacturing/models/manufacturing_order_list_model.dart';
import 'package:suppwayy_mobile/suppwayy_config.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ManufacturingOrderService extends MainRepository {
  MainRepository mainRepository = MainRepository();
  Future<ManufacturingOrderListModel> fetchManufacturingOrder() async {
    Uri uri = Uri.parse(SuppWayy.getManufactoringOrder);
    var response = await http.get(uri, headers: getHeadersWithAuthorization);

    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> jsonResponse = json.decode(response.body);
      final ManufacturingOrderListModel manufacturingOrdersList =
          ManufacturingOrderListModel.fromMap(jsonResponse);

      return manufacturingOrdersList;
    } else {
      throw Exception('Failed to load Manufactoring order');
    }
  }

  Future<bool> addManufacturingOrder(List<ManufacturingLineData> lines,
      String name, DateTime date, String status) async {
    Uri uri = Uri.parse(SuppWayy.getManufactoringOrder);
    String data = """{
          "name":"$name",
          "date":"${date.toIso8601String()}",
          "state": "${status.toUpperCase()}"}""";

    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.post(uri, headers: headers, body: data);

    if (response.statusCode == HttpStatus.created) {
      final ManufacturingOrder manufacturingOrder =
          ManufacturingOrder.fromJson(response.body.toString());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteManufacturingOrder(int manufacturingOrderID) async {
    Uri uri =
        Uri.parse(SuppWayy.getManufactoringOrder + '$manufacturingOrderID');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == HttpStatus.noContent) {
      return true;
    } else {
      throw Exception('Failed to delete this manufacturing order');
    }
  }

  Future<bool> patchManufacturingOrder(
      int manufacturingOrderID, Map updatedManufacturingOrderData) async {
    Uri uri =
        Uri.parse(SuppWayy.getManufactoringOrder + '$manufacturingOrderID');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(updatedManufacturingOrderData));
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  //  "product" : {"id": ${lineData.product!.id}},
  //   "rawProductLots" : {"rawProductsLotId": ${lineData.rawProductsLots!.id}},
  //   "finishedProductLots" : {"finishedProductsLotId":${lineData.finishedProductsLots!.id}},
  //   "billOfMaterial":"${lineData.bom}",
  Future<bool> addManufacturingOrderLine(
    int manufacturingOrderID,
    int quantity,
    // ManufacturingLineData lineData,
  ) async {
    Uri uri = Uri.parse(SuppWayy.getManufacturingLineUrl(manufacturingOrderID));
    String data = """{
      "quantity":"$quantity",
    

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

  Future<bool> deleteManufacturingOrderLine(
      int manufacturingOrderID, int manufacturingOrderLineID) async {
    Uri uri = Uri.parse(SuppWayy.getManufacturingLineUrl(manufacturingOrderID) +
        '/$manufacturingOrderLineID');

    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.delete(uri, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateManufacturingOrderLine(
      int manufacturingOrderID,
      int manufacturingOrderLineID,
      Map updatedManufacturingOrderLineData) async {
    Uri uri = Uri.parse(SuppWayy.getManufacturingLineUrl(manufacturingOrderID) +
        '/$manufacturingOrderLineID');

    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(updatedManufacturingOrderLineData));

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }
}
