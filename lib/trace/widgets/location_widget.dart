import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/commons/bloc/userlocation_bloc.dart';
import 'package:suppwayy_mobile/location/bloc/location_bloc.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';

class LocationdWidget extends StatefulWidget {
  const LocationdWidget({
    Key? key,
    required this.setUserLocation,
  }) : super(key: key);
  final ValueChanged setUserLocation;

  @override
  _LocationdWidgetState createState() => _LocationdWidgetState();
}

class _LocationdWidgetState extends State<LocationdWidget> {
  late String locationInput;
  final locationInputt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocListener<UserlocationBloc, UserlocationState>(
      listener: (context, state) {
        if (state is UserLocationLoaded) {
          BlocProvider.of<LocationBloc>(context)
              .add(GetLocationByPosition(position: state.position));
        }
      },
      child: Row(
        children: [
          SizedBox(
            width: width * 0.85,
            child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 20.0, right: 20.0),
                child: BlocBuilder<LocationBloc, LocationState>(
                    builder: (context, state) {
                  List<String> locationList = [];
                  String locale = Localizations.localeOf(context).toString();
                  if (state is LocationsLoaded) {
                    locationList = filterLocationNames(
                        state.locationsListModel.locations, locale);
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue value) {
                        if (value.text.isEmpty) {
                          return [locationList.first];
                        }
                        return locationList.where((location) => location
                            .toLowerCase()
                            .contains(value.text.toLowerCase()));
                      },
                      onSelected: (value) {
                        setState(() {
                          locationInputt.text = value.toString();
                          widget.setUserLocation(locationInputt.text);
                        });
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: InputDecoration(
                            label: Text(
                              translate("trace.location"),
                              style: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return translate("error.emptyText");
                            }
                            return null;
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(translate("location.errorLoading")),
                    );
                  }
                })),
          ),
          SizedBox(
            width: width * 0.15,
            child: IconButton(
              iconSize: 30,
              icon: Icon(Icons.location_on_outlined),
              onPressed: () {
                BlocProvider.of<UserlocationBloc>(context)
                    .add(const UserlocationEvent());
                widget.setUserLocation(locationInput);
              },
            ),
          )
        ],
      ),
    );
  }
}

List<String> filterLocationNames(List<Location> locationsList, String locale) {
  List<String> location = [];
  locationsList.every((local) {
    location.add(local.ledgerName.toString().toLowerCase());
    return true;
  });
  return location;
}
