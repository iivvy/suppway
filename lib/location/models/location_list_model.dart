import 'dart:convert';
import 'package:flutter/foundation.dart';

class LocationListModel {
  final List<Location> locations;

  const LocationListModel({this.locations = const []});

  factory LocationListModel.fromMap(List<dynamic> locations) {
    return LocationListModel(
      locations: List<Location>.from(locations.map((l) => Location.fromMap(l))),
    );
  }

  factory LocationListModel.fromJson(String source) =>
      LocationListModel.fromMap(json.decode(source));
  @override
  String toString() => '$locations)';

  Map<String, dynamic> toMap() {
    return {
      'locations': locations.map((l) => l.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  LocationListModel copyWith({
    List<Location>? locations,
  }) {
    return LocationListModel(
      locations: locations ?? this.locations,
    );
  }

  @override
  int get hashCode {
    return locations.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationListModel && listEquals(other.locations, locations);
  }
}

class Location {
  int? id;
  String? name;
  String? ledgerName;
  String gln;
  String street;
  int number;
  String postalcode;
  String city;
  String country;
  double lon;
  double lat;
  double? z;
  String? status;

  Location({
    this.id,
    this.name,
    this.ledgerName,
    required this.gln,
    required this.street,
    required this.number,
    required this.postalcode,
    required this.city,
    required this.country,
    required this.lon,
    required this.lat,
    this.z,
    this.status,
  });

  @override
  String toString() {
    return 'Location(id: $id, name: $name,ledgerName: $ledgerName,gln: $gln, number: $number, street: $street, postalcode: $postalcode, city: $city, country: $country, lon: $lon, lat: $lat,z: $z,status : $status ,)';
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map["id"] ?? 0,
      ledgerName: map["ledgerName"] ?? "",
      name: map["name"] ?? "",
      gln: map["gln"] ?? "",
      street: map['street'] ?? "",
      number: map['number'] ?? 0,
      postalcode: map["postalcode"] ?? "",
      city: map["city"] ?? "",
      country: map["country"] ?? "",
      lon: map["lon"] ?? 0.0,
      lat: map["lat"] ?? 0.0,
      z: map["z"] ?? 0.0,
      status: map["status"] ?? "",
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ledgerName': ledgerName,
      'gln': gln,
      'street': street,
      'number': number,
      'postalcode': postalcode,
      'city': city,
      'country': country,
      'lon': lon,
      'lat': lat,
      'z': z,
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));
  Location copyWith({
    int? id,
    String? name,
    String? ledgerName,
    String? gln,
    String? street,
    int? number,
    String? postalcode,
    String? city,
    String? country,
    double? lon,
    double? lat,
    double? z,
    String? status,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      ledgerName: ledgerName ?? this.ledgerName,
      gln: gln ?? this.gln,
      street: street ?? this.street,
      number: number ?? this.number,
      postalcode: postalcode ?? this.postalcode,
      city: city ?? this.city,
      country: country ?? this.country,
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
      z: z ?? this.z,
      status: status ?? this.status,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      ledgerName.hashCode ^
      gln.hashCode ^
      street.hashCode ^
      number.hashCode ^
      postalcode.hashCode ^
      city.hashCode ^
      country.hashCode ^
      lon.hashCode ^
      lat.hashCode ^
      z.hashCode ^
      status.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Location &&
        other.id == id &&
        other.name == name &&
        other.ledgerName == ledgerName &&
        other.gln == gln &&
        other.street == street &&
        other.number == number &&
        other.postalcode == postalcode &&
        other.city == city &&
        other.lon == lon &&
        other.lat == lat &&
        other.z == z &&
        other.status == status;
  }
}
