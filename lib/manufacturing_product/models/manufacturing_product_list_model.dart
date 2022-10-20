import 'dart:convert';

import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';

class ManufacturingProductListModel {
  List<ManufacturingProduct> manufacturingProducts;

  ManufacturingProductListModel({this.manufacturingProducts = const []});
  factory ManufacturingProductListModel.fromMap(
      List<dynamic> manufacturingProducts) {
    return ManufacturingProductListModel(
      manufacturingProducts: List<ManufacturingProduct>.from(
          manufacturingProducts.map((x) => ManufacturingProduct.fromMap(x))),
    );
  }

  factory ManufacturingProductListModel.fromJson(String source) =>
      ManufacturingProductListModel.fromMap(json.decode(source));
  @override
  String toString() =>
      'ProductsListModel(manufacturingProducts: $manufacturingProducts)';
  Map<String, dynamic> toMap() {
    return {
      'manufacturingProducts':
          manufacturingProducts.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  ManufacturingProductListModel copyWith({
    List<ManufacturingProduct>? manufacturingProducts,
  }) {
    return ManufacturingProductListModel(
      manufacturingProducts:
          manufacturingProducts ?? this.manufacturingProducts,
    );
  }
}

class ManufacturingProduct extends Product {
  ManufacturingProduct({
    int? id,
    required String name,
    String? description,
    required String gtin,
    bool? published,
    String? status,
    required double taxe,
    required int quantity,
    required double volume,
    String? image,
    List<Map<String, dynamic>>? medias,
    required double standardprice,
    List<Lot>? lots,
    // List<BillOfMaterial> bom,
    // List<BillOfMaterialLine> bomLine,
  }) : super(
          id: id,
          name: name,
          gtin: gtin,
          description: description,
          published: published,
          standardprice: standardprice,
          status: status,
          quantity: quantity,
          volume: volume,
          image: image,
          medias: medias,
          lots: lots,
          taxe: taxe,
          // this.bom,
          // this.bomLine,
        );
  factory ManufacturingProduct.fromMap(Map<String, dynamic> map) {
    return ManufacturingProduct(
        id: map['id'],
        name: map['name'] ?? "",
        gtin: map['gtin'] ?? "",
        description: map['description'] ?? "",
        published: map['published'],
        standardprice:
            map['standardprice'] != null ? map['standardprice'].toDouble() : 0,
        status: map['status'] ?? "",
        quantity: map['quantity'] ?? 00,
        volume: map['volume'] ?? 0.0,
        image: map['image'] ?? "",
        medias: List<Map<String, dynamic>>.from(
            map['media'].map((x) => {"id": x['id'], "url": x["url"]})),
        lots: List<Lot>.from(map['lots']?.map((x) => Lot.fromMap(x))),
        taxe: map['taxe'] != null ? map['taxe'].toDouble() : 0);
  }
  @override
  String toString() {
    return 'ManufacturingProduct';
  }

  @override
  String toJson() => json.encode(toMap());
  factory ManufacturingProduct.fromJson(String source) =>
      ManufacturingProduct.fromMap(json.decode(source));
  @override
  ManufacturingProduct copyWith({
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
    return ManufacturingProduct(
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

  @override
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

    return other is ManufacturingProduct &&
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
