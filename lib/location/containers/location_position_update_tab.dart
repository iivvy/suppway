import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/location/bloc/location_bloc.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';

class LocationPositionUpdateTab extends StatefulWidget {
  const LocationPositionUpdateTab({
    Key? key,
    required this.location,
    required this.setLat,
    required this.setLon,
  }) : super(key: key);
  final Location location;
  final ValueChanged setLat;
  final ValueChanged setLon;

  @override
  State<LocationPositionUpdateTab> createState() =>
      _LocationPositionUpdateTabState();
}

class _LocationPositionUpdateTabState extends State<LocationPositionUpdateTab> {
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    latController.text = widget.location.lat.toString();
    lonController.text = widget.location.lon.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: latController,
              textInputAction: TextInputAction.send,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: translate("location.lat"),
                labelText: translate("location.lat"),
              ),
              onFieldSubmitted: (value) {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<LocationBloc>(context).add(PatchLocation(
                      locationId: widget.location.id!,
                      updatedLocationData: {
                        "lat": double.parse(latController.text)
                      }));
                  widget.setLat(double.parse(value));
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return translate("error.emptyText");
                }
                return null;
              },
            ),
            TextFormField(
              controller: lonController,
              textInputAction: TextInputAction.send,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: translate("location.lon"),
                labelText: translate("location.lon"),
              ),
              onFieldSubmitted: (value) {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<LocationBloc>(context).add(PatchLocation(
                      locationId: widget.location.id!,
                      updatedLocationData: {
                        "lon": double.parse(lonController.text)
                      }));
                  widget.setLon(double.parse(value));
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return translate("error.emptyText");
                }
                return null;
              },
            ),
            // Container(
            //   padding: EdgeInsets.only(top: 30),
            //   child: ElevatedButton.icon(
            //     onPressed: () {
            //       //TODO calc poistion from the addresse
            //     },
            //     label: Text(translate("location.button.getPosition")),
            //     icon: Icon(Icons.location_on_outlined),
            //   ),
            // )
          ]),
        ));
  }
}
