import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/manufacturing/bloc/manufacturing_order_bloc.dart';
import 'package:suppwayy_mobile/manufacturing_product/bloc/manufacturing_product_bloc.dart';

import '../manufacturing_product/models/manufacturing_product_list_model.dart';

class UpdateManufacturingOrderLinePage extends StatefulWidget {
  const UpdateManufacturingOrderLinePage({Key? key}) : super(key: key);

  @override
  State<UpdateManufacturingOrderLinePage> createState() =>
      _UpdateManufacturingOrderLinePageState();
}

class _UpdateManufacturingOrderLinePageState
    extends State<UpdateManufacturingOrderLinePage> {
  late Lot selectedRawLot;
  late Lot selectedFinishedLot;
  bool rawLotSelected = false;
  bool finishedLotSelected = false;
  bool productSelected = false;
  TextEditingController quantityController = TextEditingController(text:'1');
  late ManufacturingProduct selectedProduct;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('update line'),
        actions: [
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.check,size: 30,))

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
                            Padding(padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller:quantityController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return translate('error');
                                  }
                                  return null;
                                },
                                cursorColor: Theme.of(context).primaryColor,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: translate('manufacturing.quantity'),
                                  label: Text(translate('manufacturing.quantity'))
                                ),
                                
                              ),
                            )
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
