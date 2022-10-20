import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class TraceListModel extends Equatable {
  final List<Trace> traces;

  const TraceListModel({this.traces = const []});

  @override
  String toString() => '$traces';

  factory TraceListModel.fromMap(List<dynamic> traces) {
    return TraceListModel(
      traces: List<Trace>.from(traces.map((x) => Trace.fromMap(x))),
    );
  }

  factory TraceListModel.fromJson(String source) =>
      TraceListModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'traces': traces.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  static String encode(TraceListModel traces) => json.encode(
        traces.traces
            .map<Map<String, dynamic>>((traces) => traces.toMap())
            .toList(),
      );

  TraceListModel copyWith({
    List<Trace>? traces,
  }) {
    return TraceListModel(
      traces: traces ?? this.traces,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is TraceListModel &&
      other.runtimeType == runtimeType &&
      other.traces == traces;
  @override
  int get hashCode => traces.hashCode;

  @override
  List<Object?> get props => throw UnimplementedError();
}

class Trace {
  String lastTransferDate;
  String locationID;

  Trace({
    required this.lastTransferDate,
    required this.locationID,
  });

  @override
  String toString() {
    return '{"lastTransferDate": "$lastTransferDate", "locationID": "$locationID"}';
  }

  factory Trace.fromMap(Map<String, dynamic> map) {
    return Trace(
      lastTransferDate: map['lastTransferDate'] ?? "",
      locationID: map['locationID'] ?? "",
    );
  }
  String toJson() => json.encode(toMap());
  factory Trace.fromJson(String source) => Trace.fromMap(json.decode(source));
  Map<String, dynamic> toMap() {
    return {
      'lastTransferDate': lastTransferDate,
      'locationID': locationID,
    };
  }

  Trace copyWith({
    String? lastTransferDate,
    String? locationID,
  }) {
    return Trace(
      lastTransferDate: lastTransferDate ?? this.lastTransferDate,
      locationID: locationID ?? this.locationID,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Trace) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => lastTransferDate.hashCode ^ locationID.hashCode;
}
