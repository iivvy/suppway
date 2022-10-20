import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';

class LotListModel extends Equatable {
  final List<Lot> lots;

  const LotListModel({this.lots = const []});

  factory LotListModel.fromMap(List<dynamic> lots) {
    return LotListModel(
      lots: List<Lot>.from(lots.map((x) => Lot.fromMap(x))),
    );
  }

  factory LotListModel.fromJson(String source) =>
      LotListModel.fromMap(json.decode(source));
  @override
  String toString() => 'LotListModel(lots: $lots)';
  Map<String, dynamic> toMap() {
    return {
      'Lots': lots.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  LotListModel copyWith({
    List<Lot>? lots,
  }) {
    return LotListModel(
      lots: lots ?? this.lots,
    );
  }

  @override
  int get hashCode => lots.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LotListModel && listEquals(other.lots, lots);
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

class Lot {
  final int id;
  final String reference;
  final DateTime date;
  final int quantity;
  final Location location;

  const Lot({
    required this.id,
    required this.reference,
    required this.date,
    required this.quantity,
    required this.location,
  });

  factory Lot.fromMap(Map<String, dynamic> map) {
    return Lot(
      id: map['id'].toInt(),
      reference: map['reference'] ?? "",
      date: DateTime.parse(map['date']),
      quantity: map['quantity'].toInt(),
      location: Location.fromMap(map["location"]),
    );
  }
  String toJson() => json.encode(toMap());
  @override
  String toString() {
    return 'Lot(id: $id, reference: $reference, date: $date, quantity: $quantity, location: $location,)';
  }

  factory Lot.fromJson(String source) => Lot.fromMap(json.decode(source));

  Lot copyWith({
    int? id,
    String? reference,
    DateTime? date,
    int? quantity,
    Location? location,
    //  Product? product,
  }) {
    return Lot(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      date: date ?? this.date,
      quantity: quantity ?? this.quantity,
      location: location ?? this.location,
      // product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reference': reference,
      'date': date.toIso8601String(),
      'quantity': quantity,
      'location': location,
      // 'product': product,
    };
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        date.hashCode ^
        location.hashCode ^
        quantity.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Lot &&
        other.id == id &&
        other.reference == reference &&
        other.date == date &&
        other.quantity == quantity &&
        other.location == location;
  }
}
