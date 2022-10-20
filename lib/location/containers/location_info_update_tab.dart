import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/location/bloc/location_bloc.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';

class LocationInformationUpdateTab extends StatefulWidget {
  const LocationInformationUpdateTab({
    Key? key,
    required this.location,
  }) : super(key: key);
  final Location location;

  @override
  State<LocationInformationUpdateTab> createState() =>
      _LocationInformationUpdateTabState();
}

class _LocationInformationUpdateTabState
    extends State<LocationInformationUpdateTab> {
  TextEditingController nameController = TextEditingController();
  TextEditingController glnController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController.text = widget.location.name!;
    glnController.text = widget.location.gln;
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
              controller: nameController,
              textInputAction: TextInputAction.send,
              decoration: InputDecoration(
                hintText: translate("location.name"),
                labelText: translate("location.name"),
              ),
              onFieldSubmitted: (value) {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<LocationBloc>(context).add(PatchLocation(
                      locationId: widget.location.id!,
                      updatedLocationData: {"name": nameController.text}));
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
              controller: glnController,
              textInputAction: TextInputAction.send,
              decoration: InputDecoration(
                hintText: translate("location.gln"),
                labelText: translate("location.gln"),
              ),
              onFieldSubmitted: (value) {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<LocationBloc>(context).add(PatchLocation(
                      locationId: widget.location.id!,
                      updatedLocationData: {"gln": glnController.text}));
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return translate("error.emptyText");
                }
                return null;
              },
            ),
          ]),
        ));
  }
}
