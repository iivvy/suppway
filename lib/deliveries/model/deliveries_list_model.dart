import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'deliveries_line_model.dart';

class DeliveriesListModel {
  final List<Delivery> delivery;

  const DeliveriesListModel({this.delivery = const []});

  factory DeliveriesListModel.fromMap(List<dynamic> deliverieslines) {
    return DeliveriesListModel(
      delivery:
          List<Delivery>.from(deliverieslines.map((x) => Delivery.fromMap(x))),
    );
  }

  factory DeliveriesListModel.fromJson(String source) =>
      DeliveriesListModel.fromMap(json.decode(source));
  @override
  String toString() => 'DeliveriesListModel($delivery)';
  Map<String, dynamic> toMap() {
    return {
      'delivery': delivery.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  DeliveriesListModel copyWith({
    List<Delivery>? deliverieslines,
  }) {
    return DeliveriesListModel(
      delivery: deliverieslines ?? delivery,
    );
  }

  @override
  int get hashCode => delivery.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeliveriesListModel && listEquals(other.delivery, delivery);
  }
}

class Delivery {
  int? id;
  DateTime date;
  String state;
  String signatureMethod;
  String? address;
  String? order;
  int? quantity;
  bool signed;
  DeliveriesLinesListModel? saleDeliveryLines;

  Delivery(
      {this.id,
      required this.date,
      required this.state,
      required this.signatureMethod,
      required this.signed,
      this.address,
      this.order,
      this.quantity,
      this.saleDeliveryLines});

  @override
  String toString() {
    return 'Delivery(id: $id, date: $date, state: $state, signatureMethod: $signatureMethod, address: $address, order: $order, quantity: $quantity, signed: $signed, saleDeliveryLines: $saleDeliveryLines)';
  }

  factory Delivery.fromMap(Map<String, dynamic> map) {
    return Delivery(
      id: map['id'],
      date: DateTime.parse(map['date'] ?? ""),
      state: map['state'] ?? "",
      signatureMethod: map['signatureMethod'] ?? "",
      address: map['address'] ?? "",
      order: map['order'] ?? "",
      quantity: map['quantity'] ?? 0,
      signed: map['signed'] ?? false,
      saleDeliveryLines:
          DeliveriesLinesListModel.fromMap(map["saleDeliveryLines"] ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date.toIso8601String(),
        'state': state,
        'signatureMethod': signatureMethod,
        'address': address,
        'order': order,
        'quantity': quantity,
        'signed': signed,
        'saleDeliveryLines': saleDeliveryLines
      };

  String toJson() => json.encode(toMap());
  factory Delivery.fromJson(String source) =>
      Delivery.fromMap(json.decode(source));

  Delivery copyWith({
    int? id,
    DateTime? date,
    String? state,
    String? signatureMethod,
    String? address,
    String? order,
    int? quantity,
    bool? signed,
    DeliveriesLinesListModel? saleDeliveryLines,
  }) {
    return Delivery(
      id: id ?? this.id,
      date: date ?? this.date,
      state: state ?? this.state,
      signatureMethod: signatureMethod ?? this.signatureMethod,
      address: address ?? this.address,
      order: order ?? this.order,
      quantity: quantity ?? this.quantity,
      signed: signed ?? this.signed,
      saleDeliveryLines: saleDeliveryLines ?? this.saleDeliveryLines,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Delivery) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      state.hashCode ^
      signatureMethod.hashCode ^
      address.hashCode ^
      order.hashCode ^
      quantity.hashCode ^
      signed.hashCode ^
      saleDeliveryLines.hashCode;
}
