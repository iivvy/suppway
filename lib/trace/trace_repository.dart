import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:suppwayy_mobile/main_repository.dart';
import 'package:suppwayy_mobile/trace/models/trace_history_model.dart';
import 'package:suppwayy_mobile/trace/models/trace_list_model.dart';
import 'package:suppwayy_mobile/trace/models/trace_request_model.dart';
// import 'package:suppwayy_mobile/suppwayy_config.dart';

class TraceService extends MainRepository {
  MainRepository mainRepository = MainRepository();
  List<TraceHistory> traceHistoryList = [];

  /// Get trace list history from SharedPreferences
  Future<List<TraceHistory>> getTraceHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? traceString = prefs.getStringList('tracelist');
    if (traceString != null) {
      traceHistoryList = List<TraceHistory>.from(
          traceString.map((x) => TraceHistory.fromJson(x)));
    }

    return traceHistoryList;
  }

  ///Update Saved List of Traces if new max Saved < listTrace.lenght
  Future<List<TraceHistory>> updateTraceHistory(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (traceHistoryList.length > value) {
      int lengthRemove = traceHistoryList.length - value;
      traceHistoryList.removeRange(0, lengthRemove);

      await prefs.remove('tracelist');
      prefs.setStringList(
          'tracelist', traceHistoryList.map((e) => e.toString()).toList());
    }

    return traceHistoryList;
  }

  /// delete element of list trace history with onDismissed
  Future<List<TraceHistory>> deleteTracefHistory(
      {required TraceHistory index}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    TraceHistory traceList = index;
    if (traceHistoryList.isNotEmpty) {
      traceHistoryList.remove(traceList);
      await prefs.remove('tracelist');
      prefs.setStringList(
          'tracelist', traceHistoryList.map((e) => e.toString()).toList());
    }

    return traceHistoryList;
  }

  Future<Map<String, dynamic>> traceProduct(
      {String? barreCode,
      String? qrCode,
      String? location,
      String? lot}) async {
    // Map<dynamic, dynamic> userAgent = await mainRepository.getUserAgent;
    // Map<String, String> params = {
    //   'gs1GTIN': barreCode.toString(),
    //   'traceableItemID': qrCode.toString(),
    //   'lotNumber': lot.toString(),
    //   'locationID': location.toString(),
    // };
    // Uri uri = Uri.parse(SuppWayy.trace);

    // var response =
    //     await http.post(uri, headers: getHeadersWithAuthorization, body: jsonEncode(params));

    // if (response.statusCode == HttpStatus.ok) {
    // List<dynamic> responseJson = json.decode(response.body);
    List<dynamic> responseJson = json.decode(
        '[{"lastTransferDate": "2022-10-14","locationID": "loc3"},{"lastTransferDate": "2010-11-15","locationID": "loc2"},{"lastTransferDate": "2022-12-14","locationID": "loc4"}]');
    TraceProductRequest traceRequest = TraceProductRequest(
        gs1GTIN: barreCode.toString(),
        traceableItemID: qrCode.toString(),
        lotNumber: lot.toString(),
        locationID: location.toString());
    TraceListModel traceList = TraceListModel.fromMap(responseJson);

    TraceHistory traceHistory = TraceHistory.fromMap(
        {"traceList": traceList, "traceRequest": traceRequest});

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? maxSavedTraces = prefs.getInt('maxSavedTraces') ?? 5;
    if (responseJson.isNotEmpty) {
      if (traceHistoryList.length >= maxSavedTraces) {
        traceHistoryList.removeAt(0);
      }
      traceHistoryList.add(traceHistory);
      await prefs.remove('tracelist');
      prefs.setStringList(
          'tracelist', traceHistoryList.map((e) => e.toString()).toList());
    }

    return {"success": true, "trace": traceHistory};
    // } else {
    //   return {"success": false, "message": "Failed to loaded trace"};
    // }
  }
}
