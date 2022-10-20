import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:latlong2/latlong.dart';
import 'package:suppwayy_mobile/location/containers/location_adress_update_tab.dart';
import 'package:suppwayy_mobile/location/containers/location_position_update_tab.dart';
import 'package:suppwayy_mobile/location/widgets/location_map.dart';
import 'containers/location_info_update_tab.dart';
import 'models/location_list_model.dart';

class LocationDetailsPage extends StatefulWidget {
  const LocationDetailsPage({Key? key, required this.location})
      : super(key: key);
  final Location location;
  @override
  State<LocationDetailsPage> createState() => _LocationDetailsPageState();
}

class _LocationDetailsPageState extends State<LocationDetailsPage> {
  double lat = 48.860684567760764;
  double lon = 2.294096492044686;
  MapController mapController = MapController();

  @override
  void initState() {
    lat = widget.location.lat;
    lon = widget.location.lon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: height * 0.3,
              width: width,
              child: Card(
                elevation: 5.0,
                child: LocationMapWidget(
                  lat: lat,
                  lon: lon,
                  mapController: mapController,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: height / 1.5,
              child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.black26,
                        tabs: [
                          Text(
                            translate("location.info"),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            translate("location.address"),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            translate("location.position"),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      LocationInformationUpdateTab(
                        location: widget.location,
                      ),
                      LocationAdressUpdateTab(
                        location: widget.location,
                      ),
                      LocationPositionUpdateTab(
                        location: widget.location,
                        setLat: (value) {
                          setState(() {
                            lat = value;
                          });
                          mapController.move(LatLng(value, lon), 10);
                        },
                        setLon: (value) {
                          setState(() {
                            lon = value;
                          });
                          mapController.move(LatLng(value, lon), 10);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
