import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';

import 'package:suppwayy_mobile/main_repository.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';
import 'package:suppwayy_mobile/sale/models/line_data.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_list_model.dart';
import 'package:suppwayy_mobile/suppwayy_config.dart';
import 'models/sale_order_optional_line_model.dart';

class SaleOrderService extends MainRepository {
  /// Function parameter documentation[SaleOrderListModel]
  MainRepository mainRepository = MainRepository();
  Future<SaleOrderListModel> fetchSalesOrder() async {
    Uri uri = Uri.parse(SuppWayy.getSalesOrder);
    var response = await http.get(uri, headers: getHeadersWithAuthorization);

    if (response.statusCode == HttpStatus.ok) {
      final String rawSalesOrdersList = response.body.toString();
      final SaleOrderListModel salesOrdersList =
          SaleOrderListModel.fromJson(rawSalesOrdersList);
      return salesOrdersList;
    } else {
      throw Exception('Failed to load Sales order');
    }
  }

  Future<Map<String, dynamic>> addSaleOrder(
    List<LineData> lines,
    String name,
    String comment,
    Partner partner,
    DateTime date,
    int deliverylocationId,
  ) async {
    String data = """{"name": "$name",
            "comment": "$comment",
            "deliveryLocation":{"id":"$deliverylocationId"},
            "buyer": {"id": ${partner.id}},
            "date": "${date.toIso8601String()}"
            }""";
    Uri uri = Uri.parse(SuppWayy.getSalesOrder);
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.post(uri, headers: headers, body: data);
    if (response.statusCode == HttpStatus.created) {
      final SaleOrder saleOrder = SaleOrder.fromJson(response.body.toString());
      for (var element in lines) {
        String dat = """{
            "name": "${element.name}",
            "quantity": ${element.quantity.toInt()},
            "price": ${element.price.toDouble()},
            "discount": ${element.discount.toDouble()},
            "taxe": ${element.taxe.toDouble()},
            "product": {"id": ${element.product.id}},
            "lot": {"id": ${element.lot.id}}
        }""";

        Uri uri = Uri.parse(SuppWayy.getLinesUrl(saleOrder.id));
        var response = await http.post(uri,
            headers: getHeadersWithAuthorization, body: dat);
        if (response.statusCode == HttpStatus.created) {
          return {"success": true, "message": "created"};
        } else {
          return {"success": false, "message": "failed"};
        }
      }
      return {"success": true, "message": "created"};
    } else {
      return {"success": false, "message": "failed"};
    }
  }

  Future<Map<String, dynamic>> updateSaleOrder(Map updatedSaleOrderData) async {
    Uri uri =
        Uri.parse(SuppWayy.getSalesOrder + '${updatedSaleOrderData["id"]}');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response =
        await http.put(uri, headers: headers, body: updatedSaleOrderData);
    if (response.statusCode == HttpStatus.ok) {
      return {"success": true, "message": "updated"};
    } else {
      return {"success": false, "message": "failed"};
    }
  }

  Future<Map<String, dynamic>> patchSaleOrder(
      int saleOrderID, Map updatedSaleOrderData) async {
    Uri uri = Uri.parse(SuppWayy.getSalesOrder + '$saleOrderID');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(updatedSaleOrderData));
    if (response.statusCode == HttpStatus.ok) {
      return {"success": true, "message": "updated"};
    } else {
      return {"success": false, "message": "failed"};
    }
  }

  Future<Map<String, dynamic>> deleteSaleOrder(int saleOrderID) async {
    Uri uri = Uri.parse(SuppWayy.getSalesOrder + '$saleOrderID');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == HttpStatus.noContent) {
      return {"success": true, "message": "deleted"};
    } else {
      return {"success": false, "message": "failed"};
    }
  }

  Future<Map<String, dynamic>> addSaleOrderLine(
      int saleOrderID, LineData lineData) async {
    Uri uri = Uri.parse(SuppWayy.getLinesUrl(saleOrderID));
    String data = """{
            "name": "${lineData.name}",
            "quantity": ${lineData.quantity.toInt()},
            "price": ${lineData.price.toDouble()},
            "discount": ${lineData.discount.toDouble()},
            "taxe": ${lineData.taxe.toDouble()},
            "product": {"id": ${lineData.product.id}},
            "lot": {"id": ${lineData.lot.id}}
        }""";
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";

    var response = await http.post(uri, headers: headers, body: data);
    if (response.statusCode == HttpStatus.created) {
      return {"success": true, "message": "created"};
    } else {
      return {"success": false, "message": "failed"};
    }
  }

  Future<Map<String, dynamic>> patchSaleOrderLine(int saleOrderID,
      int saleOrderLineID, Map updatedSaleOrderLineData) async {
    Uri uri =
        Uri.parse(SuppWayy.getLinesUrl(saleOrderID) + '/$saleOrderLineID');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(updatedSaleOrderLineData));
    if (response.statusCode == HttpStatus.ok) {
      return {"success": true, "message": "updated"};
    } else {
      return {"success": false, "message": "failed"};
    }
  }

  Future<Map<String, dynamic>> updateSaleOrderLine(
      int saleOrderID, LineData saleOrderLineData) async {
    Uri uri = Uri.parse(SuppWayy.getLinesUrl(saleOrderID));
    String data = """{
            "name": "${saleOrderLineData.name}",
            "id": ${saleOrderLineData.id},
            "quantity": ${saleOrderLineData.quantity.toInt()},
            "price": ${saleOrderLineData.price.toDouble()},
            "discount": ${saleOrderLineData.discount.toDouble()},
            "taxe": ${saleOrderLineData.taxe.toDouble()},
            "product": {"id": ${saleOrderLineData.product.id}},
            "lot": {"id": ${saleOrderLineData.lot.id}}
        }""";
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.put(uri, headers: headers, body: data);
    if (response.statusCode == HttpStatus.ok) {
      return {"success": true, "message": "updated"};
    } else {
      return {"success": false, "message": "failed"};
    }
  }

  Future<Map<String, dynamic>> deleteSaleOrderLine(
      int saleOrderID, int saleOrderLineID) async {
    Uri uri =
        Uri.parse(SuppWayy.getLinesUrl(saleOrderID) + '/$saleOrderLineID');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.delete(uri, headers: headers);

    if (response.statusCode == HttpStatus.noContent) {
      return {"success": true, "message": "deleted"};
    } else {
      return {"success": false, "message": "failed"};
    }
  }

  Future<Map<String, dynamic>> printSaleOrder(
    int saleOrderID,
  ) async {
    Uri uri = Uri.parse(SuppWayy.getPrintUrl(saleOrderID));
    var response = await http.get(uri, headers: getHeadersWithAuthorization);
    List<int> list = response.body.codeUnits;
    Uint8List data = Uint8List.fromList(list);

    if (response.statusCode == HttpStatus.ok) {
      var file = await writeFile(data, 'FileSaleOrder');
      OpenFile.open(file.path);
      return {"success": true};
    }
    return {"success": false};
  }

  Future<File> writeFile(Uint8List data, String name) async {
    Directory? downloadsDirectory = await getExternalStorageDirectory();

    String path = downloadsDirectory!.path;
    var filePath = path + '/$name';
    var bytes = ByteData.view(data.buffer);
    final buffer = bytes.buffer;

    /// save the data in the path
    return File('$filePath.PDF').writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<Map<String, dynamic>> sendEmailSaleOrder(
    int saleOrderID,
  ) async {
    Uri uri = Uri.parse(SuppWayy.getSendUrl(saleOrderID));
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      return {"success": true};
    } else {
      return {"success": false};
    }
  }

  Future<Map<String, dynamic>> addSaleOrderOptionalLine(
      int saleOrderID, SaleOrderOptionalLine optionalLineData) async {
    Uri uri = Uri.parse(SuppWayy.getOptionalLinesUrl(saleOrderID));
    String data = """{
            "product": {"id": ${optionalLineData.product.id}},
            "discount": ${optionalLineData.discount}
        }""";
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.post(uri, headers: headers, body: data);
    if (response.statusCode == HttpStatus.created) {
      return {"success": true, "message": "created"};
    } else {
      return {"success": false, "message": "failed"};
    }
  }

  Future<bool> patchOptionalLine(
      int salOrderId, int optionalLineId, Map updatedOptionalLineData) async {
    Uri uri = Uri.parse(
        SuppWayy.getOptionalLinesUrl(salOrderId) + '/$optionalLineId');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(updatedOptionalLineData));
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteOptionalLine(int saleOrderId, int optionalLineId) async {
    Uri uri = Uri.parse(
        SuppWayy.getOptionalLinesUrl(saleOrderId) + '/$optionalLineId');
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
