import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';

class PartnerListModel extends Equatable {
  final List<Partner> partners;

  const PartnerListModel({this.partners = const []});

  factory PartnerListModel.fromMap(List<dynamic> partners) {
    return PartnerListModel(
      partners: List<Partner>.from(partners.map((x) => Partner.fromMap(x))),
    );
  }

  factory PartnerListModel.fromJson(String source) =>
      PartnerListModel.fromMap(json.decode(source));
  @override
  String toString() => 'PartenerListrModel(Partners: $partners)';
  Map<String, dynamic> toMap() {
    return {
      'partners': partners.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  PartnerListModel copyWith({
    List<Partner>? partners,
  }) {
    return PartnerListModel(
      partners: partners ?? this.partners,
    );
  }

  @override
  int get hashCode => partners.hashCode;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PartnerListModel && listEquals(other.partners, partners);
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

class Partner {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String email;
  final String website;
  final String status;
  final String photo;
  final String stripeId;
  final LocationListModel? locations;

  const Partner(
      {required this.id,
      required this.name,
      required this.phone,
      required this.address,
      required this.email,
      required this.website,
      required this.status,
      required this.photo,
      this.locations,
      required this.stripeId});
  factory Partner.fromMap(Map<String, dynamic> map) {
    return Partner(
      id: map['id'].toInt(),
      name: map['name'] ?? "",
      phone: map['phone'] ?? "",
      address: map['address'] ?? "",
      email: map['email'] ?? "",
      website: map['website'] ?? "",
      status: map['status'] ?? "",
      photo: map['photo'] ?? "",
      stripeId: map['stripeId'] ?? "",
      locations: LocationListModel.fromMap(map['locations'] ?? []),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      'website': website,
      'status': status,
      'photo': photo,
      'stripeId': stripeId,
      'locations': locations!.locations,
    };
  }

  @override
  String toString() {
    return 'Partner(id: $id, name: $name, phone: $phone,address: $address,email : $email,website : $website,status : $status,photo : $photo,stripeId:$stripeId,locations : $locations)';
  }

  String toJson() => json.encode(toMap());

  factory Partner.fromJson(String source) =>
      Partner.fromMap(json.decode(source));

  Partner copyWith({
    int? id,
    String? name,
    String? phone,
    String? address,
    String? email,
    String? website,
    String? status,
    String? photo,
    String? stripeId,
    LocationListModel? locations,
  }) {
    return Partner(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      email: email ?? this.email,
      website: website ?? this.website,
      status: status ?? this.status,
      photo: photo ?? this.photo,
      stripeId: stripeId ?? this.stripeId,
      locations: locations ?? this.locations,
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        email.hashCode ^
        status.hashCode ^
        photo.hashCode ^
        locations.hashCode ^
        stripeId.hashCode ^
        website.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Partner &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.website == website &&
        other.status == status &&
        other.photo == photo &&
        other.locations == locations &&
        other.stripeId == stripeId &&
        other.address == address;
  }
}
