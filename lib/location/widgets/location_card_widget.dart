import 'package:flutter/material.dart';
import 'package:suppwayy_mobile/location/location_details_page.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';
import 'package:suppwayy_mobile/utils/launch_maps.dart';

class LocationCardWidget extends StatelessWidget {
  const LocationCardWidget({Key? key, required this.location})
      : super(key: key);
  final Location location;

  void _launchMapsUrl(double lat, double lon) async {
    MapsLauncher.launchCoordinates(lat, lon);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationDetailsPage(location: location),
          ),
        );
      },
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          leading: Container(
            constraints: BoxConstraints(maxWidth: 80.0, maxHeight: 40.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).backgroundColor.withOpacity(0.4)),
            child: Center(
              child: Text(location.postalcode.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12.0)),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(location.name!, style: const TextStyle(fontSize: 15.0)),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(location.gln, style: const TextStyle(fontSize: 12.0)),
          ),
          trailing: ElevatedButton(
              onPressed: () {
                _launchMapsUrl(location.lat, location.lon);
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
                primary: Color(0xff44A07E), // <-- Button color
                onPrimary: Colors.white, // <-- Splash color
              ),
              child: Icon(Icons.directions)),
        ),
      ),
    );
  }
}
