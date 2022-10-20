import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';

import 'models/product_list_model.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController gtinController = TextEditingController();
  TextEditingController quatiteController = TextEditingController();
  TextEditingController valumeController = TextEditingController();
  TextEditingController taxeController = TextEditingController();
  TextEditingController standardPriceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translate("product.Addproduct")),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.check,
                size: 30,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<ProductBloc>(context).add(AddProductEvent(
                      productData: Product(
                    name: nameController.text,
                    gtin: gtinController.text,
                    quantity: int.parse(quatiteController.text),
                    volume: double.parse(valumeController.text),
                    taxe: double.parse(taxeController.text),
                    standardprice: double.parse(standardPriceController.text),
                  )));
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration:
                        InputDecoration(label: Text(translate("product.name"))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return translate("error.emptyText");
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: gtinController,
                    decoration: InputDecoration(
                      hintText: translate("trace.hinttext.codebar"),
                      labelText: translate("trace.codebar"),
                      suffixIcon: IconButton(
                          onPressed: () {
                            scanQrCode().then((value) {
                              gtinController.text = value;
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
                  TextFormField(
                    controller: quatiteController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        label: Text(translate("product.quantity"))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return translate("error.emptyText");
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: valumeController,
                    decoration: InputDecoration(
                        label: Text(translate("product.volume"))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return translate("error.emptyText");
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: taxeController,
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(label: Text(translate("product.taxe"))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return translate("error.emptyText");
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: standardPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        label: Text(translate("product.standarPrice"))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return translate("error.emptyText");
                      }
                      return null;
                    },
                  ),
                ],
              )),
        )));
  }

  Future<dynamic> scanQrCode() async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#000000', 'Cancel', true, ScanMode.BARCODE);
    return qrCode;
  }
}
