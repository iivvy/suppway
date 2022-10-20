import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';

class DeliveriesLinesListModel {
  final List<DeliveryLines> deliveriesLines;

  const DeliveriesLinesListModel({this.deliveriesLines = const []});

  factory DeliveriesLinesListModel.fromMap(List<dynamic> deliverieslines) {
    return DeliveriesLinesListModel(
      deliveriesLines: List<DeliveryLines>.from(
          deliverieslines.map((x) => DeliveryLines.fromMap(x))),
    );
  }

  factory DeliveriesLinesListModel.fromJson(String source) =>
      DeliveriesLinesListModel.fromMap(json.decode(source));
  @override
  String toString() => 'DeliveriesListModel:$deliveriesLines';
  Map<String, dynamic> toMap() {
    return {
      'deliveriesLines': deliveriesLines.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  DeliveriesLinesListModel copyWith({
    List<DeliveryLines>? deliverieslines,
  }) {
    return DeliveriesLinesListModel(
      deliveriesLines: deliverieslines ?? deliveriesLines,
    );
  }

  @override
  int get hashCode => deliveriesLines.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeliveriesLinesListModel &&
        listEquals(other.deliveriesLines, deliveriesLines);
  }
}

class DeliveryLines {
  int id;
  int quantity;
  String state;
  String comment;
  Lot? lot;
  Product product;

  DeliveryLines(
      {required this.id,
      required this.quantity,
      required this.product,
      required this.state,
      required this.comment,
      this.lot});

  @override
  String toString() {
    return 'DeliveryLines(id: $id,quantity: $quantity,product: $product,state: $state,state: $comment, lot: $lot)';
  }

  factory DeliveryLines.fromMap(Map<String, dynamic> map) {
    return DeliveryLines(
        id: map['id'],
        quantity: map['quantity'],
        state: map['state'] ?? "",
        comment: map['comment'] ?? "",
        lot: map["lot"] == null ? null : Lot.fromMap(map["lot"]),
        product: Product.fromMap(map["product"]));
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'quantity': quantity,
        'state': state,
        'comment': comment,
        'lot': lot,
        'product': product
      };

  String toJson() => json.encode(toMap());
  factory DeliveryLines.fromJson(String source) =>
      DeliveryLines.fromMap(json.decode(source));

  DeliveryLines copyWith({
    int? id,
    int? quantity,
    String? state,
    String? comment,
    Lot? lot,
    Product? product,
  }) {
    return DeliveryLines(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      state: state ?? this.state,
      comment: comment ?? this.comment,
      lot: lot ?? this.lot,
      product: product ?? this.product,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DeliveryLines) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      quantity.hashCode ^
      state.hashCode ^
      comment.hashCode ^
      product.hashCode ^
      lot.hashCode;
}
