import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';

import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_optional_line_model.dart';
import 'sale_order_line_list_model.dart';

class SaleOrderListModel {
  final List<SaleOrder> salesOrders;

  const SaleOrderListModel({this.salesOrders = const []});

  factory SaleOrderListModel.fromMap(List<dynamic> salesOrders) {
    return SaleOrderListModel(
      salesOrders:
          List<SaleOrder>.from(salesOrders.map((x) => SaleOrder.fromMap(x))),
    );
  }

  factory SaleOrderListModel.fromJson(String source) =>
      SaleOrderListModel.fromMap(json.decode(source));
  @override
  String toString() => 'salesorderListModel(products: $salesOrders)';
  Map<String, dynamic> toMap() {
    return {
      'sales Order': salesOrders.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  SaleOrderListModel copyWith({
    List<SaleOrder>? salesOrders,
  }) {
    return SaleOrderListModel(
      salesOrders: salesOrders ?? this.salesOrders,
    );
  }

  @override
  int get hashCode => salesOrders.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaleOrderListModel &&
        listEquals(other.salesOrders, salesOrders);
  }
}

class SaleOrder {
  final int id;
  final String name;
  final String comment;
  final DateTime date;
  final double taxes;
  final double total;
  final double taxedTotal;
  final String addedAt;
  final SaleOrderLineListModel lines;
  final SaleOrderOptionalLineListModel optionalLines;
  final Partner buyer;
  final String status;
  final Location deliveryLocation;

  SaleOrder(
      {required this.id,
      required this.name,
      required this.comment,
      required this.date,
      required this.addedAt,
      required this.taxes,
      required this.total,
      required this.taxedTotal,
      required this.lines,
      required this.buyer,
      required this.status,
      required this.deliveryLocation,
      required this.optionalLines});
  factory SaleOrder.fromMap(Map<String, dynamic> map) {
    LocationListModel location = const LocationListModel();
    Partner buyer = Partner(
      id: 0,
      name: "",
      phone: "",
      address: "",
      email: "",
      website: "",
      photo: '',
      locations: location,
      status: '',
      stripeId: '',
    );
    if (map.containsKey("buyer")) {
      buyer = Partner.fromMap(map["buyer"]);
    }
    Location deliveryLocation = Location(
        id: 0,
        ledgerName: "ledgerName",
        gln: "gln",
        street: "street",
        number: 0,
        postalcode: "postalcode",
        city: "city",
        lon: 0,
        lat: 0,
        z: 0,
        status: "draft",
        country: '');
    if (map.containsKey("deliveryLocation") &&
        map["deliveryLocation"] != null) {
      deliveryLocation = Location.fromMap(map['deliveryLocation']);
    }
    return SaleOrder(
      id: map['id'].toInt(),
      name: map['name'] ?? "",
      comment: map['comment'] ?? "",
      date: DateTime.parse(map['date']),
      addedAt: map['addedAt'] ?? "",
      taxes: map['taxes'].toDouble(),
      total: map['total'].toDouble(),
      taxedTotal: map['taxedTotal'].toDouble(),
      buyer: buyer,
      lines: SaleOrderLineListModel.fromMap(map["lines"]),
      status: map['status'] ?? "",
      deliveryLocation: deliveryLocation,
      optionalLines:
          SaleOrderOptionalLineListModel.fromMap(map["optionalLines"]),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'comment': comment,
      'date': date,
      'addedAt': addedAt,
      "taxes": taxes,
      "total": total,
      "taxedTotal": taxedTotal,
      'lines': lines,
      'buyer': buyer,
      'status': status,
      'deliveryLocation': deliveryLocation,
      'optionalLines': optionalLines,
    };
  }

  @override
  String toString() {
    return 'sale(id: $id, name: $name, comment: $comment,date: $date,addedAt : $addedAt,lines : $lines,buyer : $buyer,status : $status, deliveryLocation : $deliveryLocation)';
  }

  String toJson() => json.encode(toMap());

  factory SaleOrder.fromJson(String source) =>
      SaleOrder.fromMap(json.decode(source));

  SaleOrder copyWith(
      {int? id,
      String? name,
      String? comment,
      DateTime? date,
      String? addedAt,
      double? taxes,
      double? total,
      double? taxedTotal,
      SaleOrderLineListModel? lines,
      Partner? buyer,
      String? status,
      Location? deliveryLocation,
      SaleOrderOptionalLineListModel? optionalLines}) {
    return SaleOrder(
      id: id ?? this.id,
      name: name ?? this.name,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      addedAt: addedAt ?? this.addedAt,
      taxes: taxes ?? this.taxes,
      total: total ?? this.total,
      taxedTotal: taxedTotal ?? this.taxedTotal,
      lines: lines ?? this.lines,
      buyer: buyer ?? this.buyer,
      status: status ?? this.status,
      deliveryLocation: deliveryLocation ?? this.deliveryLocation,
      optionalLines: optionalLines ?? this.optionalLines,
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        comment.hashCode ^
        date.hashCode ^
        addedAt.hashCode ^
        lines.hashCode ^
        buyer.hashCode ^
        status.hashCode ^
        deliveryLocation.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaleOrder &&
        other.id == id &&
        other.name == name &&
        other.comment == comment &&
        other.date == date &&
        other.addedAt == addedAt &&
        other.lines == lines &&
        other.buyer == buyer &&
        other.status == status &&
        other.deliveryLocation == deliveryLocation;
  }
}
