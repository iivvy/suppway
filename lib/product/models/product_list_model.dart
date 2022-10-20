import 'dart:convert';

//import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';

class ProductListModel extends Equatable {
  final List<Product> products;

  const ProductListModel({this.products = const []});

  factory ProductListModel.fromMap(List<dynamic> products) {
    return ProductListModel(
      products: List<Product>.from(products.map((x) => Product.fromMap(x))),
    );
  }

  factory ProductListModel.fromJson(String source) =>
      ProductListModel.fromMap(json.decode(source));
  @override
  String toString() => 'ProductsListModel(products: $products)';
  Map<String, dynamic> toMap() {
    return {
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  ProductListModel copyWith({
    List<Product>? products,
  }) {
    return ProductListModel(
      products: products ?? this.products,
    );
  }

  @override
  int get hashCode => products.hashCode;

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductListModel && listEquals(other.products, products);
  }
}

class Product {
  final int? id;
  final String name;
  final String? description;
  final String gtin;
  final bool? published;
  final String? status;
  final double taxe;
  final int quantity;
  final double volume;
  final String? image;
  final List<Map<String, dynamic>>? medias;
  final double standardprice;
  final List<Lot>? lots;

  Product({
    this.id,
    required this.name,
    required this.gtin,
    this.description,
    this.published,
    required this.standardprice,
    this.status,
    required this.quantity,
    required this.volume,
    this.image,
    this.medias,
    this.lots,
    required this.taxe,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      gtin: map['gtin'] ?? "",
      published: map['published'],
      status: map['status'] ?? "",
      quantity: map['quantity'] ?? 0,
      volume: map['volume'] ?? 0.0,
      image: map['image'] ?? "",
      //todo listString
      medias: List<Map<String, dynamic>>.from(
          map['media'].map((x) => {"id": x['id'], "url": x["url"]})),
      standardprice:
          map['standardprice'] != null ? map['standardprice'].toDouble() : 0,
      description: map['description'] ?? "",
      lots: List<Lot>.from(map['lots']?.map((x) => Lot.fromMap(x))),
      taxe: map['taxe'] != null ? map['taxe'].toDouble() : 0,
    );
  }
  String toJson() => json.encode(toMap());
  @override
  String toString() {
    return 'Product(id: $id, name: $name, gtin: $gtin, description:$description, published: $published, status : $status, quantity: $quantity, volume: $volume, image: $image, media : $medias, standardprice : $standardprice, lots : $lots, taxe:$taxe)';
  }

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  Product copyWith({
    int? id,
    String? name,
    String? gtin,
    String? description,
    bool? published,
    String? status,
    int? quantity,
    double? volume,
    String? image,
    List<Map<String, dynamic>>? medias,
    double? standardprice,
    List<Lot>? lots,
    double? taxe,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      gtin: gtin ?? this.gtin,
      description: description ?? this.description,
      published: published ?? this.published,
      standardprice: standardprice ?? this.standardprice,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      volume: volume ?? this.volume,
      image: image ?? this.image,
      medias: medias ?? this.medias,
      lots: lots ?? this.lots,
      taxe: taxe ?? this.taxe,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gtin': gtin,
      'description': description,
      'published': published,
      'standardprice': standardprice,
      'status': status,
      'quantity': quantity,
      'volume': volume,
      'image': image,
      'media': medias,
      'lots': lots!.map((x) => x.toMap()).toList(),
      'taxe': taxe,
    };
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        gtin.hashCode ^
        description.hashCode ^
        published.hashCode ^
        status.hashCode ^
        quantity.hashCode ^
        volume.hashCode ^
        image.hashCode ^
        medias.hashCode ^
        standardprice.hashCode ^
        lots.hashCode ^
        taxe.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.gtin == gtin &&
        other.description == description &&
        other.published == published &&
        other.status == status &&
        other.quantity == quantity &&
        other.volume == volume &&
        other.image == image &&
        other.medias == medias &&
        other.standardprice == standardprice &&
        other.lots == lots &&
        other.taxe == taxe;
  }
}
