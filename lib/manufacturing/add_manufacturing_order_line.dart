import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/manufacturing/models/line_data.dart';
import 'package:suppwayy_mobile/manufacturing/models/manufacturing_order_list_model.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';

import '../manufacturing_product/bloc/manufacturing_product_bloc.dart';
import '../manufacturing_product/models/manufacturing_product_list_model.dart';
import 'bloc/manufacturing_order_bloc.dart';

class AddManufacturingOrderLine extends StatefulWidget {
  const AddManufacturingOrderLine({
    Key? key,
    this.manufacturingOrder,
  }) : super(key: key);
  final ManufacturingOrder? manufacturingOrder;
  @override
  State<AddManufacturingOrderLine> createState() =>
      _AddManufacturingOrderLineState();
}

class _AddManufacturingOrderLineState extends State<AddManufacturingOrderLine> {
  late ManufacturingProduct selectedProduct;
  bool productSelected = false;
  late Lot selectedRawLot;
  late Lot selectedFinishedLot;
  bool rawLotSelected = false;
  bool finishedLotSelected = false;

  TextEditingController productController = TextEditingController();
  TextEditingController rawProductsLotController = TextEditingController();
  TextEditingController finishedProductsLotController = TextEditingController();
  TextEditingController bomController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translate("manufacturing.newline")),
          actions: [
            IconButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   BlocProvider.of<ManufacturingOrderBloc>(context).add(
                  //     AddManufacturingOrderLineEvent(
                  //       manufacturingOrderID: widget.manufacturingOrder!.id!,
                  //       manufacturingOrderLineData: ManufacturingLineData(
                  //           bom: bomController.text,
                  //           rawProductsLots: selectedRawLot,
                  //           finishedProductsLots: selectedFinishedLot,
                  //           product: selectedProduct),
                  //     ),
                  //   );
                  //   Navigator.pop(context);
                  // }

                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_formKey.currentState!.validate()) {
                    // BlocProvider.of<ManufacturingOrderBloc>(context)
                    //     .add(AddManufacturingOrderLineEvent(
                    //   manufacturingOrderID: widget.manufacturingOrder!.id!,
                    //   quantity: int.parse(quantityController.text),
                    // ));

                    ManufacturingLineData manufacturingOrderLineData =
                        ManufacturingLineData(
                      quantity: int.parse(quantityController.text),
                    );

                    Navigator.pop(context, manufacturingOrderLineData);
                  }
                },
                icon: Icon(Icons.check))
          ],
        ),
      body: ListView(
        children: [
          SizedBox(
            child: SingleChildScrollView(
              child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 20,top: 20),
                        child: BlocBuilder<ManufacturingProductBloc,
                            ManufacturingProductState>(
                            builder: (context, state){
                              if (state is ManufacturingProductsLoaded) {
                                return Column(children: [
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      label: Text(translate("sale.product")),
                                    ),
                                    isExpanded: true,
                                    focusColor:
                                    Theme.of(context).primaryColor,
                                    icon: Icon(Icons.arrow_drop_down),
                                    onChanged: (int? newVlaue) {
                                      productSelected = true;
                                      ManufacturingProduct chosenProduct = state.manufacturingProducts
                                          .singleWhere(
                                              (c) => c.id == newVlaue);
                                      setState(() {
                                        selectedProduct = chosenProduct;
                                        selectedRawLot = selectedProduct.lots!.first;
                                        selectedFinishedLot=selectedProduct.lots!.first;
                                        quantityController.text = selectedProduct.quantity.toString();
                                      });
                                    },
                                    value: productSelected
                                        ? selectedProduct.id
                                        : state.manufacturingProducts.first.id,
                                    items: state.manufacturingProducts
                                        .map<DropdownMenuItem<int>>(
                                            (ManufacturingProduct p) {
                                          return DropdownMenuItem<int>(
                                              key: UniqueKey(),
                                              value: p.id,
                                              child: Text(p.name));
                                        }).toList(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          label: Text(translate(
                                              "manufacturing.Rawlot"))),
                                      isExpanded: true,
                                      focusColor:
                                      Theme.of(context).primaryColor,
                                      icon: Icon(Icons.arrow_drop_down),
                                      onChanged: (int? newValue) {
                                        Lot chosenRawLot = productSelected
                                            ? selectedProduct.lots!
                                            .singleWhere(
                                                (l) => l.id == newValue)
                                            : state
                                            .manufacturingProducts.first.lots!.first;
                                        setState(() {
                                          selectedRawLot = chosenRawLot;
                                        });
                                      },
                                      value: productSelected
                                          ? selectedRawLot.id
                                          : state
                                          .manufacturingProducts.first.lots!.first.id,
                                      items: productSelected
                                          ? selectedProduct.lots!
                                          .map<DropdownMenuItem<int>>(
                                              (Lot l) {
                                            return DropdownMenuItem<int>(
                                                key: UniqueKey(),
                                                value: l.id,
                                                child: Text(l.reference));
                                          }).toList()
                                          : state.manufacturingProducts.first.lots!
                                          .map<DropdownMenuItem<int>>(
                                              (Lot l) {
                                            return DropdownMenuItem<int>(
                                                key: UniqueKey(),
                                                value: l.id,
                                                child: Text(l.reference));
                                          }).toList(),

                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          label: Text(translate(
                                              "manufacturing.Finishedlot"))),
                                      isExpanded: true,
                                      focusColor:
                                      Theme.of(context).primaryColor,
                                      icon: Icon(Icons.arrow_drop_down),
                                      onChanged: (int? newValue) {
                                        Lot chosenRawLot = productSelected
                                            ? selectedProduct.lots!
                                            .singleWhere(
                                                (l) => l.id == newValue)
                                            : state
                                            .manufacturingProducts.first.lots!.first;
                                        setState(() {
                                          selectedFinishedLot = chosenRawLot;
                                        });
                                      },
                                      value: productSelected
                                          ? selectedFinishedLot.id
                                          : state
                                          .manufacturingProducts.first.lots!.first.id,
                                      items: productSelected
                                          ? selectedProduct.lots!
                                          .map<DropdownMenuItem<int>>(
                                              (Lot l) {
                                            return DropdownMenuItem<int>(
                                                key: UniqueKey(),
                                                value: l.id,
                                                child: Text(l.reference));
                                          }).toList()
                                          : state.manufacturingProducts.first.lots!
                                          .map<DropdownMenuItem<int>>(
                                              (Lot l) {
                                            return DropdownMenuItem<int>(
                                                key: UniqueKey(),
                                                value: l.id,
                                                child: Text(l.reference));
                                          }).toList(),

                                    ),
                                  ),


                                ]);
                              }else {
                                return Text('loading error');}
                            }
                        ),
                      )
                    ],
                  )),
            ),
          ),

        ],
      ),
    );
  }
}
