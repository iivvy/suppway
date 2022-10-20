import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationMapWidget extends StatelessWidget {
  const LocationMapWidget(
      {Key? key,
      required this.lat,
      required this.lon,
      required this.mapController})
      : super(key: key);
  final double lat;
  final double lon;

  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: LatLng(lat, lon),
        zoom: 10.0,
        interactiveFlags: InteractiveFlag.pinchMove |
            InteractiveFlag.pinchZoom |
            InteractiveFlag.drag |
            InteractiveFlag.flingAnimation |
            InteractiveFlag.doubleTapZoom,
        enableScrollWheel: true,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              anchorPos: AnchorPos.align(AnchorAlign.center),
              point: LatLng(
                lat,
                lon,
              ),
              builder: (context) => const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
