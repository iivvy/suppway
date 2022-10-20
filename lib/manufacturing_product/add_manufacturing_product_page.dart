import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/manufacturing_product/bloc/manufacturing_product_bloc.dart';
import 'package:suppwayy_mobile/manufacturing_product/models/manufacturing_product_list_model.dart';

class AddMdnufacturingProductPage extends StatefulWidget {
  const AddMdnufacturingProductPage({Key? key}) : super(key: key);

  @override
  State<AddMdnufacturingProductPage> createState() =>
      _AddMdnufacturingProductPageState();
}

class _AddMdnufacturingProductPageState
    extends State<AddMdnufacturingProductPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController gtinController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController volumeController = TextEditingController();
  TextEditingController taxeController = TextEditingController();
  TextEditingController standardPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //TODO add status property
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("product.Addproduct")),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<ManufacturingProductBloc>(context)
                    .add(AddManufacturingProductEvent(
                        manufacturingProductData: ManufacturingProduct(
                  name: nameController.text,
                  gtin: gtinController.text,
                  quantity: int.parse(quantityController.text),
                  volume: double.parse(volumeController.text),
                  taxe: double.parse(taxeController.text),
                  standardprice: double.parse(standardPriceController.text),
                  description: descriptionController.text,
                )));
                Navigator.pop(context);
              }
            },
            icon: Icon(
              Icons.check,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(label: Text('name')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'empty filed';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: gtinController,
                    decoration: InputDecoration(
                      label: Text('code bar'),
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
                        return 'empty filed';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: quantityController,
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
                    controller: volumeController,
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
                    decoration: InputDecoration(
                        label: Text(translate("product.standardPrice"))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return translate("error.emptyText");
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(label: Text('description')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return translate("error.emptyText");
                      }
                      return null;
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future<dynamic> scanQrCode() async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#000000', 'Cancel', true, ScanMode.BARCODE);
    return qrCode;
  }
}
