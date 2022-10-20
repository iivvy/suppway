import 'dart:convert';

import 'package:collection/collection.dart';

class TraceProductRequest {
  String gs1GTIN;
  String traceableItemID;
  String lotNumber;
  String locationID;

  TraceProductRequest({
    required this.gs1GTIN,
    required this.traceableItemID,
    required this.lotNumber,
    required this.locationID,
  });

  @override
  String toString() {
    return '{"gs1GTIN": "$gs1GTIN","lotNumber": "$lotNumber","locationID" : "$locationID" ,"traceableItemID" : "$traceableItemID"}';
  }

  String toJson() => json.encode(toMap());
  factory TraceProductRequest.fromJson(String source) =>
      TraceProductRequest.fromMap(json.decode(source));

  factory TraceProductRequest.fromMap(Map<String, dynamic> map) {
    return TraceProductRequest(
      gs1GTIN: map['gs1GTIN'] ?? "",
      traceableItemID: map['traceableItemID'] ?? "",
      lotNumber: map['lotNumber'] ?? "",
      locationID: map['locationID'] ?? "",
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'gs1GTIN': gs1GTIN,
      'traceableItemID': traceableItemID,
      'lotNumber': lotNumber,
      'locationID': locationID,
    };
  }

  TraceProductRequest copyWith({
    String? gs1GTIN,
    String? traceableItemID,
    String? lotNumber,
    String? locationID,
  }) {
    return TraceProductRequest(
        gs1GTIN: gs1GTIN ?? this.gs1GTIN,
        traceableItemID: traceableItemID ?? this.traceableItemID,
        lotNumber: lotNumber ?? this.lotNumber,
        locationID: locationID ?? this.locationID);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TraceProductRequest) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      gs1GTIN.hashCode ^
      traceableItemID.hashCode ^
      lotNumber.hashCode ^
      locationID.hashCode;
}
