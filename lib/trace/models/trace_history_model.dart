import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:suppwayy_mobile/trace/models/trace_list_model.dart';
import 'package:suppwayy_mobile/trace/models/trace_request_model.dart';

class TraceHistory {
  final TraceListModel traceList;
  final TraceProductRequest traceRequest;

  TraceHistory({
    required this.traceList,
    required this.traceRequest,
  });

  @override
  String toString() {
    return '{"traceList": $traceList,"traceRequest": $traceRequest}';
  }

  String toJson() => json.encode(toMap());
  factory TraceHistory.fromJson(String source) {
    Map<String, dynamic> jsonSource = json.decode(source);
    Map<String, dynamic> jsonTraceHistory = {
      "traceList": TraceListModel.fromMap(jsonSource["traceList"]),
      "traceRequest": TraceProductRequest.fromMap(jsonSource["traceRequest"])
    };

    return TraceHistory.fromMap(jsonTraceHistory);
  }

  factory TraceHistory.fromMap(Map<String, dynamic> map) {
    return TraceHistory(
      traceList: map["traceList"],
      traceRequest: map["traceRequest"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'traceList': traceList,
      'traceRequest': traceRequest,
    };
  }

  TraceHistory copyWith({
    TraceListModel? traceList,
    TraceProductRequest? traceRequest,
  }) {
    return TraceHistory(
        traceList: traceList ?? this.traceList,
        traceRequest: traceRequest ?? this.traceRequest);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TraceHistory) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => traceList.hashCode ^ traceRequest.hashCode;
}
