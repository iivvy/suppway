import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LocationInformationAddTab extends StatelessWidget {
  const LocationInformationAddTab({
    Key? key,
    required this.name,
    required this.gln,
    required this.setName,
    required this.setGln,
  }) : super(key: key);
  final String name;
  final String gln;
  final ValueChanged setName;
  final ValueChanged setGln;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
        children: [
          TextFormField(
            initialValue: name,
            onChanged: (value) {
              setName(value);
            },
            decoration: InputDecoration(
              hintText: translate("location.name"),
              labelText: translate("location.name"),
            ),
          ),
          TextFormField(
            initialValue: gln,
            onChanged: (value) {
              setGln(value);
            },
            decoration: InputDecoration(
              hintText: translate("location.gln"),
              labelText: translate("location.gln"),
            ),
          ),
        ],
      ),
    );
  }
}
