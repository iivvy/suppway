import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/location/bloc/location_bloc.dart';
import 'package:suppwayy_mobile/location/containers/location_adress_add_tab.dart';
import 'package:suppwayy_mobile/location/containers/location_info_add_tab.dart';
import 'package:suppwayy_mobile/location/containers/location_position_add_tab.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({Key? key}) : super(key: key);

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  late String nameInput = "";
  late String glnInput = "";
  late String streetInput = "";
  late String numberInput = "";
  late String postalCodeInput = "";
  late String cityInput = "";
  late String countryInput = "";
  late String latInput = "";
  late String lonInput = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("location.add")),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.check,
                size: 30,
              ),
              onPressed: () {
                // TODO add fields validation_validateInputs();
                BlocProvider.of<LocationBloc>(context).add(AddLocation(
                    location: Location(
                  name: nameInput,
                  gln: glnInput,
                  street: streetInput,
                  number: int.parse(numberInput),
                  postalcode: postalCodeInput,
                  city: cityInput,
                  country: countryInput,
                  lat: double.parse(latInput),
                  lon: double.parse(lonInput),
                )));
                Navigator.pop(context);
              }),
        ],
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
                child: Center(
                  child: Text("Map"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: height / 2,
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
                      LocationInformationAddTab(
                        name: nameInput,
                        gln: glnInput,
                        setName: (name) {
                          setState(() {
                            nameInput = name;
                          });
                        },
                        setGln: (gln) {
                          setState(() {
                            glnInput = gln;
                          });
                        },
                      ),
                      LocationAdressAddTab(
                        setStreet: (street) {
                          setState(() {
                            streetInput = street;
                          });
                        },
                        setCity: (city) {
                          setState(() {
                            cityInput = city;
                          });
                        },
                        setCountry: (country) {
                          setState(() {
                            countryInput = country;
                          });
                        },
                        setNumber: (number) {
                          setState(() {
                            numberInput = number;
                          });
                        },
                        setPostalCode: (postalCode) {
                          setState(() {
                            postalCodeInput = postalCode;
                          });
                        },
                        city: cityInput,
                        country: countryInput,
                        number: numberInput,
                        postalCode: postalCodeInput,
                        street: streetInput,
                      ),
                      LocationPositionAddTab(
                        setLat: (lat) {
                          setState(() {
                            latInput = lat;
                          });
                        },
                        setLon: (lon) {
                          setState(() {
                            lonInput = lon;
                          });
                        },
                        lat: latInput,
                        lon: lonInput,
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
