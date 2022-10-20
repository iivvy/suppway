import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:suppwayy_mobile/product/models/product_list_model.dart';

class SaleOrderOptionalLineListModel {
  final List<SaleOrderOptionalLine> saleOrderLines;

  const SaleOrderOptionalLineListModel({this.saleOrderLines = const []});

  factory SaleOrderOptionalLineListModel.fromMap(List<dynamic> saleOrderlines) {
    return SaleOrderOptionalLineListModel(
      saleOrderLines: List<SaleOrderOptionalLine>.from(
          saleOrderlines.map((x) => SaleOrderOptionalLine.fromMap(x))),
    );
  }

  factory SaleOrderOptionalLineListModel.fromJson(String source) =>
      SaleOrderOptionalLineListModel.fromMap(json.decode(source));
  @override
  String toString() => 'OptionalLinesList(lines: $saleOrderLines)';
  Map<String, dynamic> toMap() {
    return {
      'optionalLines': saleOrderLines.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  SaleOrderOptionalLineListModel copyWith({
    List<SaleOrderOptionalLine>? saleOrderlines,
  }) {
    return SaleOrderOptionalLineListModel(
      saleOrderLines: saleOrderlines ?? saleOrderLines,
    );
  }

  @override
  int get hashCode => saleOrderLines.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaleOrderOptionalLineListModel &&
        listEquals(other.saleOrderLines, saleOrderLines);
  }
}

class SaleOrderOptionalLine {
  final int? id;
  final double discount;
  final Product product;

  SaleOrderOptionalLine({
    this.id,
    required this.discount,
    required this.product,
  });

  factory SaleOrderOptionalLine.fromMap(Map<String, dynamic> map) {
    return SaleOrderOptionalLine(
      id: map['id'].toInt(),
      discount: map['discount'].toDouble(),
      product: Product.fromMap(map["product"]),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'discount': discount,
      'product': product,
    };
  }

  String toJson() => json.encode(toMap());
  @override
  String toString() {
    return 'Sale Order Optional Line(id: $id, discount: $discount, product: $product)';
  }

  factory SaleOrderOptionalLine.fromJson(String source) =>
      SaleOrderOptionalLine.fromMap(json.decode(source));

  SaleOrderOptionalLine copyWith({
    int? id,
    double? discount,
    Product? product,
  }) {
    return SaleOrderOptionalLine(
      id: id ?? this.id,
      discount: discount ?? this.discount,
      product: product ?? this.product,
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^ discount.hashCode ^ product.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaleOrderOptionalLine &&
        other.id == id &&
        other.discount == discount &&
        other.product == product;
  }
}
