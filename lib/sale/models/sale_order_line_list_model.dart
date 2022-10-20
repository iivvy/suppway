import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';

import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';

class SaleOrderLineListModel {
  final List<SaleOrderLine> saleOrderLines;

  const SaleOrderLineListModel({this.saleOrderLines = const []});

  factory SaleOrderLineListModel.fromMap(List<dynamic> saleOrderlines) {
    return SaleOrderLineListModel(
      saleOrderLines: List<SaleOrderLine>.from(
          saleOrderlines.map((x) => SaleOrderLine.fromMap(x))),
    );
  }

  factory SaleOrderLineListModel.fromJson(String source) =>
      SaleOrderLineListModel.fromMap(json.decode(source));
  @override
  String toString() => 'LinesListModel(lines: $saleOrderLines)';
  Map<String, dynamic> toMap() {
    return {
      'lines': saleOrderLines.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  SaleOrderLineListModel copyWith({
    List<SaleOrderLine>? saleOrderlines,
  }) {
    return SaleOrderLineListModel(
      saleOrderLines: saleOrderlines ?? saleOrderLines,
    );
  }

  @override
  int get hashCode => saleOrderLines.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaleOrderLineListModel &&
        listEquals(other.saleOrderLines, saleOrderLines);
  }
}

class SaleOrderLine {
  final int id;
  final String name;
  final int quantity;
  final double price;
  final Product product;
  final double discount;
  final double taxe;
  final double taxes;
  final double total;
  final double taxedTotal; // amount
  final Lot lot;
  SaleOrderLine({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.product,
    required this.discount,
    required this.taxe,
    required this.taxes,
    required this.total,
    required this.taxedTotal,
    required this.lot,
  });

  factory SaleOrderLine.fromMap(Map<String, dynamic> map) {
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
    Lot lot = Lot(
        id: 0,
        reference: '',
        date: DateTime.now(),
        quantity: 0,
        location: location);
    if (map["lot"] != null) {
      lot = Lot.fromMap(map["lot"]);
    }

    Product product = Product(
        id: 0,
        name: "",
        gtin: "",
        description: "",
        published: false,
        standardprice: 0,
        status: "",
        quantity: 0,
        volume: 0,
        image: "",
        medias: [],
        lots: [],
        taxe: 0);
    if (map["product"] != null) {
      product = Product.fromMap(map["product"]);
    }
    return SaleOrderLine(
      id: map['id'].toInt(),
      name: map['name'],
      quantity: map['quantity'].toInt(),
      price: map['price'] != null ? map['price'].toDouble() : 1.0,
      taxedTotal: map['amount'] != null ? map['amount'].toDouble() : 1.0,
      discount: map['discount'] != null ? map['discount'].toDouble() : 1,
      taxe: map['taxe'] != null ? map['taxe'].toDouble() : 1,
      taxes: map['taxes'].toDouble(),
      total: map['total'].toDouble(),
      product: product,
      lot: lot,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'discount': discount,
      'taxe': taxe,
      "taxes": taxes,
      "total": total,
      "taxedTotal": taxedTotal,
      'product': product,
      'lot': lot,
    };
  }

  String toJson() => json.encode(toMap());
  @override
  String toString() {
    return 'Sale Order Line(id: $id, name: $name, quantity: $quantity, price: $price, product:$product)';
  }

  factory SaleOrderLine.fromJson(String source) =>
      SaleOrderLine.fromMap(json.decode(source));

  SaleOrderLine copyWith({
    int? id,
    String? name,
    int? quantity,
    double? price,
    Product? product,
    double? amount,
    double? discount,
    double? taxe,
    double? taxes,
    double? total,
    double? taxedTotal,
    Lot? lot,
  }) {
    return SaleOrderLine(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      product: product ?? this.product,
      discount: discount ?? this.discount,
      taxe: taxe ?? this.taxe,
      taxes: taxes ?? this.taxes,
      total: total ?? this.total,
      taxedTotal: taxedTotal ?? this.taxedTotal,
      lot: lot ?? this.lot,
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        quantity.hashCode ^
        price.hashCode ^
        discount.hashCode ^
        product.hashCode ^
        lot.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaleOrderLine &&
        other.id == id &&
        other.name == name &&
        other.quantity == quantity &&
        other.price == price &&
        other.discount == discount &&
        other.taxe == taxe &&
        other.product == product &&
        other.lot == lot;
  }
}
