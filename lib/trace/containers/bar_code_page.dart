import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/trace/bloc/trace_bloc.dart';
import 'package:suppwayy_mobile/trace/widgets/location_widget.dart';

class BarCodePage extends StatefulWidget {
  const BarCodePage({Key? key}) : super(key: key);

  @override
  _BarCodePageState createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  int index = 1;
  TextEditingController barreCodeInput = TextEditingController();
  TextEditingController lotInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String locationInput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: TextFormField(
                  controller: barreCodeInput,
                  decoration: InputDecoration(
                    hintText: translate("trace.hinttext.codebar"),
                    labelText: translate("trace.codebar"),
                    suffixIcon: IconButton(
                        onPressed: () {
                          scanQrCode().then((value) {
                            barreCodeInput.text = value;
                          });
                        },
                        icon: const ImageIcon(
                            AssetImage("assets/images/scanbarcode.png"))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: TextFormField(
                  controller: lotInput,
                  decoration: InputDecoration(
                    hintText: translate("trace.hinttext.n_lot"),
                    labelText: translate("trace.n_lot"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: LocationdWidget(
                  setUserLocation: (location) {
                    locationInput = location;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton.icon(
                  label: Text(translate("trace.button.trace")),
                  icon: const ImageIcon(
                      AssetImage("assets/images/tracehome.png")),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<TraceBloc>(context).add(
                          GetTraceProductByBarCode(
                              barreCode: barreCodeInput.text,
                              lot: lotInput.text,
                              location: locationInput.toString()));

                      BlocProvider.of<TraceBloc>(context)
                          .add(GetTraceHistory());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> scanQrCode() async {
  final qrCode = await FlutterBarcodeScanner.scanBarcode(
      '#000000', 'Cancel', true, ScanMode.BARCODE);
  return qrCode;
}
