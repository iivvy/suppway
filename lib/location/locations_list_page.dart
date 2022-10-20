import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/location/bloc/location_bloc.dart';
import 'package:suppwayy_mobile/location/widgets/location_card_widget.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';
import 'package:suppwayy_mobile/setting/bloc/setting_bloc.dart';
import 'package:suppwayy_mobile/setting/linear_gradient.dart';

import 'add_location_page.dart';

class LocationListPage extends StatefulWidget {
  const LocationListPage({Key? key}) : super(key: key);

  @override
  _LocationListPageState createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  bool isSearching = false;

  final searchController = TextEditingController();
  late bool _theme;

  String value = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    searchController.addListener(_latestValue);
    super.initState();
    _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';
  }

  void _latestValue() {
    setState(() {
      value = searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text(translate("location.locations"))
            : TextField(
                onChanged: (value) {
                  _latestValue();
                },
                controller: searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: translate("location.searchlocation"),
                    hintStyle: const TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      searchController.text = "";
                      isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) async {
          if (state is LocationCreated) {
            BlocProvider.of<LocationBloc>(context).add(GetLocationsEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("location.createsuccess")),
              ),
            );
          } else if (state is LocationCreationFailed) {
            BlocProvider.of<LocationBloc>(context).add(GetLocationsEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("location.createfailed")),
              ),
            );
          }
          if (state is DeleteLocationSuccess) {
            BlocProvider.of<LocationBloc>(context).add(GetLocationsEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("location.deletesuccess")),
              ),
            );
          } else if (state is DeleteLocationError) {
            BlocProvider.of<LocationBloc>(context).add(GetLocationsEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("location.deletefailed")),
              ),
            );
          }
          if (state is LocationUpdated) {
            BlocProvider.of<LocationBloc>(context).add(GetLocationsEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("location.updatesuccess")),
              ),
            );
          } else if (state is LocationUpdateError) {
            BlocProvider.of<LocationBloc>(context).add(GetLocationsEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("location.updatefailed")),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LocationsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LocationsLoaded) {
            List<Location> _filteredlocations =
                state.locationsListModel.locations;
            if (isSearching == true) {
              _filteredlocations = state.locationsListModel.locations
                  .where((location) => location.gln
                      .toString()
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
            }
            return _filteredlocations.isNotEmpty
                ? ListView.builder(
                    itemCount: _filteredlocations.length,
                    itemBuilder: (context, index) => Center(
                        child: LocationCardWidget(
                            location: _filteredlocations[index])),
                  )
                : Center(
                    child: Text(translate("location.emptyList")),
                  );
          }
          return Center(
            child: Text(translate("location.errorLoading")),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddLocationPage(),
            ),
          );
        },
        child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: colorGradient(_theme),
            ),
            child: const Icon(Icons.add)),
      ),
    );
  }

  Future<bool> promptUser(DismissDirection direction, int locationId) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text(translate("location.deleteAlert")),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Ok"),
                onPressed: () {
                  BlocProvider.of<LocationBloc>(context)
                      .add(DeleteLocation(locationId: locationId));
                  return Navigator.of(context).pop(true);
                },
              ),
              CupertinoDialogAction(
                child: Text(translate("cancel")),
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        ) ??
        false;
  }
}
