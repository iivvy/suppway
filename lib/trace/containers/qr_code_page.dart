import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/trace/bloc/trace_bloc.dart';
import 'package:suppwayy_mobile/trace/widgets/location_widget.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  final qrCodeInput = TextEditingController();
  final lotInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String locationInput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: qrCodeInput,
                  decoration: InputDecoration(
                      hintText: translate("trace.hinttext.qrcode"),
                      labelText: translate("trace.qrcode"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          scanQrCode().then((value) {
                            qrCodeInput.text = value;
                          });
                        },
                        icon: const Icon(
                            IconData(0xf00cc, fontFamily: 'MaterialIcons')),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
              ),
              LocationdWidget(
                setUserLocation: (location) {
                  locationInput = location;
                },
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
                          GetTraceProductByQrCode(
                              qrCode: qrCodeInput.text,
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
      '#000000', 'Cancel', true, ScanMode.QR);
  return qrCode;
}
