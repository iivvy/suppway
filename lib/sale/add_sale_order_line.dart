import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';
import 'package:suppwayy_mobile/sale/models/line_data.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_list_model.dart';

class AddSaleOrderLine extends StatefulWidget {
  const AddSaleOrderLine({
    Key? key,
    this.saleOrder,
  }) : super(key: key);

  final SaleOrder? saleOrder;
  @override
  State<AddSaleOrderLine> createState() => _AddSaleOrderLineState();
}

class _AddSaleOrderLineState extends State<AddSaleOrderLine> {
  late Product selectedProduct;
  bool productSelected = false;
  bool lotSelected = false;
  late Lot selectedLot;

  TextEditingController nameContoller = TextEditingController();
  TextEditingController productContoller = TextEditingController();
  TextEditingController lotContoller = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController taxeContoller = TextEditingController();
  TextEditingController quantityContoller = TextEditingController(text: "1");
  TextEditingController discountController = TextEditingController(text: "0");

  final _formKey = GlobalKey<FormState>();

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
        title: Text(translate("line.title")),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              size: 30,
            ),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_formKey.currentState!.validate() &&
                  selectedProduct is Product) {
                LineData saleOrderLineData = LineData(
                  name: nameContoller.text,
                  quantity: int.parse(quantityContoller.text),
                  price: double.parse(priceController.text),
                  product: selectedProduct,
                  lot: selectedLot,
                  discount: double.parse(discountController.text),
                  taxe: double.parse(taxeContoller.text),
                );

                Navigator.pop(context, saleOrderLineData);
              }
            },
          ),
        ],
      ),
      body: ListView(children: [
        SizedBox(
          height: height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20, bottom: 20),
                    child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductsLoaded) {
                          return Column(
                            children: [
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                    label: Text(
                                  translate("sale.product"),
                                )),
                                isExpanded: true,
                                focusColor: Theme.of(context).primaryColor,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                ),
                                onChanged: (int? newValue) {
                                  productSelected = true;
                                  Product chosenProduct = state.products
                                      .singleWhere((c) => c.id == newValue);

                                  setState(() {
                                    selectedProduct = chosenProduct;

                                    nameContoller.text = selectedProduct.name;
                                    priceController.text = selectedProduct
                                        .standardprice
                                        .toString();
                                    taxeContoller.text =
                                        selectedProduct.taxe.toString();
                                    selectedLot = selectedProduct.lots!.first;
                                  });
                                },
                                value: productSelected
                                    ? selectedProduct.id
                                    : state.products.first.id,
                                items: state.products
                                    .map<DropdownMenuItem<int>>((Product p) {
                                  return DropdownMenuItem<int>(
                                    key: UniqueKey(),
                                    value: p.id,
                                    child: Text(p.name),
                                  );
                                }).toList(),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        label: Text(
                                      translate("sale.lot"),
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    isExpanded: true,
                                    focusColor: Theme.of(context).primaryColor,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                    onChanged: (int? newValue) {
                                      Lot chosenLot = productSelected
                                          ? selectedProduct.lots!.singleWhere(
                                              (l) => l.id == newValue)
                                          : state.products.first.lots!.first;
                                      setState(() {
                                        selectedLot = chosenLot;
                                      });
                                    },
                                    value: productSelected
                                        ? selectedLot.id
                                        : state.products.first.lots!.first.id,
                                    items: productSelected
                                        ? selectedProduct.lots!
                                            .map<DropdownMenuItem<int>>(
                                                (Lot l) {
                                            return DropdownMenuItem<int>(
                                              key: UniqueKey(),
                                              value: l.id,
                                              child: Text(l.reference),
                                            );
                                          }).toList()
                                        : state.products.first.lots!
                                            .map<DropdownMenuItem<int>>(
                                                (Lot l) {
                                            return DropdownMenuItem<int>(
                                              key: UniqueKey(),
                                              value: l.id,
                                              child: Text(l.reference),
                                            );
                                          }).toList(),
                                  )),
                            ],
                          );
                        } else {
                          return Text(translate("product.errorLoading"));
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: nameContoller,
                      style: const TextStyle(
                          fontSize: 15.0,
                          // color: Colors.black,
                          fontWeight: FontWeight.normal),
                      cursorColor: Theme.of(context).primaryColor,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return translate("error.emptyText");
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: translate("sale.name"),
                        label: Text(translate("sale.name")),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 80.0, left: 15, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: SizedBox(
                                width: width * 0.80,
                                child: TextFormField(
                                  controller: priceController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return translate("error.emptyText");
                                    }
                                    return null;
                                  },
                                  cursorColor: Theme.of(context).primaryColor,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintText: translate("sale.price"),
                                    label: Text(translate("sale.price")),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.2,
                            ),
                            Flexible(
                              child: SizedBox(
                                width: width * 0.3,
                                child: TextFormField(
                                  controller: discountController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return translate("error.emptyText");
                                    }
                                    return null;
                                  },
                                  cursorColor: Theme.of(context).primaryColor,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintText: translate("sale.discount"),
                                    label: Text(
                                      translate("sale.discount"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 80.0, left: 15, top: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.28,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return translate("error.emptyText");
                                  }
                                  return null;
                                },
                                controller: taxeContoller,
                                cursorColor: Theme.of(context).primaryColor,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: translate("sale.tax"),
                                  label: Text(
                                    translate("sale.tax"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.2,
                            ),
                            Flexible(
                              child: SizedBox(
                                width: width * 0.35,
                                child: TextFormField(
                                  controller: quantityContoller,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return translate("error.");
                                    }
                                    return null;
                                  },
                                  cursorColor: Theme.of(context).primaryColor,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintText: translate("sale.quantity"),
                                    label: Text(
                                      translate("sale.quantity"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
