import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LocationPositionAddTab extends StatelessWidget {
  const LocationPositionAddTab({
    Key? key,
    required this.setLat,
    required this.setLon,
    required this.lat,
    required this.lon,
  }) : super(key: key);
  final ValueChanged setLat;
  final ValueChanged setLon;
  final String lat;
  final String lon;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(children: [
          TextFormField(
            initialValue: lat,
            onChanged: (value) {
              setLat(value);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: translate("location.lat"),
              labelText: translate("location.lat"),
            ),
          ),
          TextFormField(
            initialValue: lon,
            onChanged: (value) {
              setLon(value);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: translate("location.lon"),
              labelText: translate("location.lon"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 220),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(translate("location.button.getPosition")),
            ),
          )
        ]));
  }
}
