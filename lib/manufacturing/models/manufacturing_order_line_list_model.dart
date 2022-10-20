// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';
import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';

class ManufacturingOrderLineListModel {
  final List<ManufacturingOrderLine> manufacturingOrderLines;
  const ManufacturingOrderLineListModel(
      {this.manufacturingOrderLines = const []});
  factory ManufacturingOrderLineListModel.fromMap(
      List<dynamic> manufacturingOrderlines) {
    return ManufacturingOrderLineListModel(
        manufacturingOrderLines: List<ManufacturingOrderLine>.from(
            manufacturingOrderlines
                .map((x) => ManufacturingOrderLine.fromMap(x))));
  }
  factory ManufacturingOrderLineListModel.fromJson(String source) =>
      ManufacturingOrderLineListModel.fromMap(json.decode(source));
  @override
  String toString() => 'LinesListModel(lines: $manufacturingOrderLines)';
  Map<String, dynamic> toMap() {
    return {
      'lines': manufacturingOrderLines.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
  ManufacturingOrderLineListModel copyWith({
    List<ManufacturingOrderLine>? manufacturingOrderlines,
  }) {
    return ManufacturingOrderLineListModel(
      manufacturingOrderLines:
          manufacturingOrderlines ?? manufacturingOrderLines,
    );
  }

  @override
  int get hashCode => manufacturingOrderLines.hashCode;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ManufacturingOrderLineListModel &&
        listEquals(other.manufacturingOrderLines, manufacturingOrderLines);
  }
}

class ManufacturingOrderLine {
  final int id;
  // final Product product;
  // final String? bom;
  // final Lot rawProductsLots;
  // final Lot? finishedProductsLots;
  final int quantity;

  ManufacturingOrderLine({
    required this.id,
    // required this.product,
    // this.bom,
    // this.finishedProductsLots,
    // required this.rawProductsLots,
    required this.quantity,
  });
  factory ManufacturingOrderLine.fromMap(Map<String, dynamic> map) {
    Location location = Location(
      id: 0,
      gln: "",
      street: "",
      postalcode: "",
      city: "",
      ledgerName: '',
      number: 0,
      lon: 0,
      lat: 0,
      z: 0,
      status: "",
      country: '',
    );
    Lot finishedProductsLots = Lot(
      id: 0,
      reference: '',
      date: DateTime.now(),
      quantity: 0,
      location: location,
    );
    if (map["finishedProductsLots"] != null) {
      finishedProductsLots = Lot.fromMap(map["finishedProductsLots"]);
    }

    Lot rawProductsLots = Lot(
      id: 0,
      reference: '',
      date: DateTime.now(),
      quantity: 0,
      location: location,
    );
    if (map["rawProductsLots"] != null) {
      rawProductsLots = Lot.fromMap(map["rawProductsLots"]);
    }
    Product product = Product(
      id: 0,
      name: ' ',
      gtin: ' ',
      standardprice: 0,
      quantity: 0,
      volume: 0,
      taxe: 0,
      description: '',
      image: '',
      medias: [],
      lots: [],
      published: false,
      status: "",
    );
    if (map["product"] != null) {
      product = Product.fromMap(map["product"]);
    }
    // ManufacturingOrder manufacturingOrder =
    //     ManufacturingOrder(name: 'name', date: DateTime.now(), status: '');
    return ManufacturingOrderLine(
      id: map['id'].toInt(),
      // product: product,
      // bom: '',
      // finishedProductsLots: finishedProductsLots,
      // rawProductsLots: rawProductsLots,
      quantity: map['quantity'].toInt(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'product': product,
      // 'bom': bom,
      // 'finishedProductsLots': finishedProductsLots,
      // 'rawProductsLots': rawProductsLots,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    // return 'Manufacturing Order Line (id: $id,product: $product, bom: $bom,finishedProductsLots:$finishedProductsLots, rawProductsLots:$rawProductsLots,quantity:$quantity)';
    return 'Manufacturing Order Line (id: $id,quantity:$quantity)';
  }

  factory ManufacturingOrderLine.fromJson(String source) =>
      ManufacturingOrderLine.fromMap(json.decode(source));
  ManufacturingOrderLine copyWith({
    int? id,
    // Product? product,
    // Lot? rawProductsLots,
    // Lot? finishedProductsLots,
    // String? bom,
    int? quantity,
  }) {
    return ManufacturingOrderLine(
        id: id ?? this.id,
        // product: product ?? this.product,
        // bom: bom ?? this.bom,
        // finishedProductsLots: finishedProductsLots ?? this.finishedProductsLots,
        // rawProductsLots: rawProductsLots ?? this.rawProductsLots,
        quantity: quantity ?? this.quantity);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        // rawProductsLots.hashCode ^
        // finishedProductsLots.hashCode ^
        // bom.hashCode ^
        quantity.hashCode;
    // product.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ManufacturingOrderLine &&
        other.id == id &&
        // other.rawProductsLots == rawProductsLots &&
        // other.finishedProductsLots == finishedProductsLots &&
        // other.bom == bom &&
        other.quantity == quantity;
    // other.product == product;
  }
}
