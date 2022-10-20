import 'dart:convert';
import 'dart:io';

import 'package:suppwayy_mobile/main_repository.dart';
import 'package:suppwayy_mobile/manufacturing_product/models/manufacturing_product_list_model.dart';

import '../suppwayy_config.dart';
import 'package:http/http.dart' as http;

class ManufacturingProductsService extends MainRepository {
  Future<ManufacturingProductListModel> fetchManufacturingProducts() async {
    Uri uri = Uri.parse(SuppWayy.getManufacturingProducts);
    var response = await http.get(uri, headers: getHeadersWithAuthorization);
    print("-----------------${response.body}");
    print(response.statusCode);
    print(uri);
    if (response.statusCode == HttpStatus.ok) {
      final String rawProductsList = response.body.toString();
      print(ManufacturingProductListModel.fromJson(rawProductsList));
      return ManufacturingProductListModel.fromJson(rawProductsList);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<bool> addManufacturingProduct(ManufacturingProduct product) async {
    Uri uri = Uri.parse(SuppWayy.getManufacturingProducts);
    String data = """{
      "name":"${product.name}",
      "gtin":"${product.gtin}",
      "quantity":${product.quantity},
      "volume":${product.volume},
      "taxe":${product.taxe},
      "standardprice":"${product.standardprice}",
      "description":"${product.description}"
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

  Future<bool> updateManufacturingProduct(
      int manufacturingProductId, Map updatedManufacturingProductData) async {
    Uri uri = Uri.parse(
        SuppWayy.getManufacturingProducts + '$manufacturingProductId');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(updatedManufacturingProductData));
    print('update response-----------${response.body}');
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> deleteManufacturingProduct(int manufacturingProductId) async{
    Uri uri = Uri.parse(SuppWayy.getManufacturingProducts + '$manufacturingProductId');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.delete(uri,headers: headers);
    if(response.statusCode == HttpStatus.noContent){
      return true;

    }else{
      return false;
    }
    
  }
}
