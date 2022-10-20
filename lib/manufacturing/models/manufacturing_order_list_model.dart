import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:suppwayy_mobile/manufacturing/models/manufacturing_order_line_list_model.dart';

class ManufacturingOrderListModel {
  final List<ManufacturingOrder> manufacturingOrders;

  const ManufacturingOrderListModel({this.manufacturingOrders = const []});

  factory ManufacturingOrderListModel.fromMap(
      List<dynamic> manufacturingOrders) {
    return ManufacturingOrderListModel(
      manufacturingOrders: List<ManufacturingOrder>.from(
          manufacturingOrders.map((x) => ManufacturingOrder.fromMap(x))),
    );
  }

  factory ManufacturingOrderListModel.fromJson(String source) =>
      ManufacturingOrderListModel.fromMap(json.decode(source));
  @override
  String toString() =>
      'ManufacturingOrderListModel(products: $manufacturingOrders)';
  Map<String, dynamic> toMap() {
    return {
      'Manufacturing Order': manufacturingOrders.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  ManufacturingOrderListModel copyWith({
    List<ManufacturingOrder>? manufacturingOrders,
  }) {
    return ManufacturingOrderListModel(
      manufacturingOrders: manufacturingOrders ?? this.manufacturingOrders,
    );
  }

  @override
  int get hashCode => manufacturingOrders.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ManufacturingOrderListModel &&
        listEquals(other.manufacturingOrders, manufacturingOrders);
  }
}

class ManufacturingOrder {
  final int? id;
  final String name;
  final DateTime date;
  final ManufacturingOrderLineListModel? lines;
  final String status;

  ManufacturingOrder({
    this.id,
    required this.name,
    required this.date,
    this.lines,
    required this.status,
  });
  factory ManufacturingOrder.fromMap(Map<String, dynamic> map) {
    return ManufacturingOrder(
      id: map['id'].toInt(),
      name: map['name'] ?? "",
      date: DateTime.parse(map['date'] ?? "1969-07-20 20:18:04Z"),
      lines: ManufacturingOrderLineListModel.fromMap(map["lines"] ?? []),
      status: map['state'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'lines': lines,
      'state': status,
    };
  }

  @override
  String toString() {
    return 'manufactruing order(id: $id, name: $name,date: $date,state : $status,lines:$lines)'; //lines : $lines
  }

  String toJson() => json.encode(toMap());

  factory ManufacturingOrder.fromJson(String source) =>
      ManufacturingOrder.fromMap(json.decode(source));

  ManufacturingOrder copyWith({
    int? id,
    String? name,
    String? comment,
    DateTime? date,
    ManufacturingOrderLineListModel? lines,
    String? status,
  }) {
    return ManufacturingOrder(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      lines: lines ?? this.lines,
      status: status ?? this.status,
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        date.hashCode ^
        lines.hashCode ^
        status.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ManufacturingOrder &&
        other.id == id &&
        other.name == name &&
        other.date == date &&
        other.lines == lines &&
        other.status == status;
  }
}
