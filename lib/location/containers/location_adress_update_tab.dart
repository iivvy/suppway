import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/location/bloc/location_bloc.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';

class LocationAdressUpdateTab extends StatefulWidget {
  const LocationAdressUpdateTab({
    Key? key,
    required this.location,
  }) : super(key: key);
  final Location location;

  @override
  State<LocationAdressUpdateTab> createState() =>
      _LocationAdressUpdateTabState();
}

class _LocationAdressUpdateTabState extends State<LocationAdressUpdateTab> {
  TextEditingController numberController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    numberController.text = widget.location.number.toString();
    streetController.text = widget.location.street;
    postalCodeController.text = widget.location.postalcode;
    cityController.text = widget.location.city;
    countryController.text = widget.location.country;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        // padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: numberController,
                textInputAction: TextInputAction.send,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: translate("location.number"),
                  labelText: translate("location.number"),
                ),
                onFieldSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<LocationBloc>(context).add(PatchLocation(
                        locationId: widget.location.id!,
                        updatedLocationData: {
                          "number": numberController.text
                        }));
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
                controller: streetController,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: translate("location.street"),
                  labelText: translate("location.street"),
                ),
                onFieldSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<LocationBloc>(context).add(PatchLocation(
                        locationId: widget.location.id!,
                        updatedLocationData: {
                          "street": streetController.text
                        }));
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
                controller: postalCodeController,
                textInputAction: TextInputAction.send,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: translate("location.postalCode"),
                  labelText: translate("location.postalCode"),
                ),
                onFieldSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<LocationBloc>(context).add(PatchLocation(
                        locationId: widget.location.id!,
                        updatedLocationData: {
                          "postalCode": postalCodeController.text
                        }));
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
                controller: cityController,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: translate("location.city"),
                  labelText: translate("location.city"),
                ),
                onFieldSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<LocationBloc>(context).add(PatchLocation(
                        locationId: widget.location.id!,
                        updatedLocationData: {"city": cityController.text}));
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
                controller: countryController,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: translate("location.country"),
                  labelText: translate("location.country"),
                ),
                onFieldSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<LocationBloc>(context).add(PatchLocation(
                        locationId: widget.location.id!,
                        updatedLocationData: {
                          "country": countryController.text
                        }));
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return translate("error.emptyText");
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
