import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LocationAdressAddTab extends StatelessWidget {
  const LocationAdressAddTab({
    Key? key,
    required this.street,
    required this.number,
    required this.postalCode,
    required this.city,
    required this.country,
    required this.setStreet,
    required this.setNumber,
    required this.setPostalCode,
    required this.setCity,
    required this.setCountry,
  }) : super(key: key);
  final ValueChanged setStreet;
  final ValueChanged setNumber;
  final ValueChanged setPostalCode;
  final ValueChanged setCity;
  final ValueChanged setCountry;
  final String street;
  final String number;
  final String postalCode;
  final String city;
  final String country;

  @override
  Widget build(BuildContext context) {
    return Padding(
        // padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextFormField(
            initialValue: number,
            onChanged: (value) {
              setNumber(value);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: translate("location.number"),
              labelText: translate("location.number"),
            ),
          ),
          TextFormField(
            initialValue: street,
            onChanged: (value) {
              setStreet(value);
            },
            decoration: InputDecoration(
              hintText: translate("location.street"),
              labelText: translate("location.street"),
            ),
          ),
          TextFormField(
            initialValue: postalCode,
            onChanged: (value) {
              setPostalCode(value);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: translate("location.postalCode"),
              labelText: translate("location.postalCode"),
            ),
          ),
          TextFormField(
            initialValue: city,
            onChanged: (value) {
              setCity(value);
            },
            decoration: InputDecoration(
              hintText: translate("location.city"),
              labelText: translate("location.city"),
            ),
          ),
          TextFormField(
            initialValue: country,
            onChanged: (value) {
              setCountry(value);
            },
            decoration: InputDecoration(
              hintText: translate("location.country"),
              labelText: translate("location.country"),
            ),
          ),
        ]));
  }
}
