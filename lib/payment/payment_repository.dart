import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:suppwayy_mobile/main_repository.dart';
import 'package:suppwayy_mobile/payment/model/payment_list_model.dart';
import '../suppwayy_config.dart';
import 'package:http/http.dart' as http;

class PaymentService extends MainRepository {
  MainRepository mainRepository = MainRepository();
  List<Payment> paymentList = [];

  ///
  /// Authorize Stripe .....
  ///
  Future<String> authorize() async {
    final uri = Uri.parse(SuppWayy.authorize);
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    } else {
      throw Exception("Server error");
    }
  }

  ///
  /// Handle Stripe return url after user validation
  ///
  Future<bool> handleRetrun(String url) async {
    final uri = Uri.parse(url);
    var headers = getHeadersWithAuthorization;
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      throw Exception("Server error");
    }
  }

  ///
  ///
  ///
  Future<bool> deAuthorize() async {
    final uri = Uri.parse(SuppWayy.deauthorize);
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      throw Exception("Server error");
    }
  }

  ///
  ///
  ///
  Future<List<Payment>> getPaymentsList(int limitListPayment) async {
    // final queryParameters = {'limit': "$limitListPayment"};

    final String response =
        await rootBundle.loadString('assets/json/payment.json');
    var data = await json.decode(response);

    // final uri = Uri.parse(SuppWayy.chargeList)
    //     .replace(queryParameters: queryParameters);
    // var headers = getHeadersWithAuthorization;
    // headers["content-type"] = "application/json";
    // var response = await http.get(uri, headers: headers);
    // var responseJson = json.decode(response.body);

    // if (response.statusCode == HttpStatus.ok) {
    paymentList = PaymentListModel.fromMap(data).payments;
    return paymentList;
    // } else {
    //   throw Exception("Server error");
    // }
  }
}
