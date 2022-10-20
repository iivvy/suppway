import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';
import 'package:suppwayy_mobile/sale/models/line_data.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_line_list_model.dart';

class UpdateSaleOrderLineContainer extends StatefulWidget {
  const UpdateSaleOrderLineContainer(
      {Key? key, required this.saleOrderLine, required this.saleOrderId})
      : super(key: key);

  final SaleOrderLine saleOrderLine;
  final int saleOrderId;
  @override
  State<UpdateSaleOrderLineContainer> createState() =>
      _UpdateSaleOrderLineContainerState();
}

class _UpdateSaleOrderLineContainerState
    extends State<UpdateSaleOrderLineContainer> {
  late Product selectedProduct;
  late Lot selectedLot;

  TextEditingController nameContoller = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController taxeContoller = TextEditingController();
  TextEditingController quantityContoller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    selectedLot = widget.saleOrderLine.lot;
    selectedProduct = widget.saleOrderLine.product;
    priceController =
        TextEditingController(text: widget.saleOrderLine.price.toString());
    quantityContoller =
        TextEditingController(text: widget.saleOrderLine.quantity.toString());
    nameContoller = TextEditingController(text: widget.saleOrderLine.name);
    taxeContoller =
        TextEditingController(text: widget.saleOrderLine.taxe.toString());
    discountController =
        TextEditingController(text: widget.saleOrderLine.discount.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<SaleOrderBloc, SaleOrderState>(
        listener: (context, state) {
          if (state is SaleOrderLineUpdated) {
            BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("line.updatesuccess")),
              ),
            );
            Navigator.pop(context);
          } else if (state is UpdateSaleOrderLineFailed) {
            BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("line.updatefailed")),
              ),
            );
          }
        },
        child: makeDismissible(
            child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(translate("line.updatetitle")),
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
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      isExpanded: true,
                                      focusColor:
                                          Theme.of(context).primaryColor,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                      onChanged: (int? newValue) {
                                        Product chosenProduct = state.products
                                            .singleWhere(
                                                (c) => c.id == newValue);

                                        setState(() {
                                          selectedProduct = chosenProduct;

                                          nameContoller = TextEditingController(
                                              text: selectedProduct.name);
                                          priceController =
                                              TextEditingController(
                                                  text: selectedProduct
                                                      .standardprice
                                                      .toString());
                                          taxeContoller = TextEditingController(
                                              text: selectedProduct.taxe
                                                  .toString());
                                          selectedLot =
                                              selectedProduct.lots!.first;
                                          BlocProvider.of<SaleOrderBloc>(
                                                  context)
                                              .add(PatchSaleOrderLineEvent(
                                                  saleOrderID:
                                                      widget.saleOrderId,
                                                  saleOrderLineID:
                                                      widget.saleOrderLine.id,
                                                  updateData: {
                                                "product_id": selectedProduct.id
                                              }));
                                        });
                                      },
                                      value: selectedProduct.id,
                                      items: state.products
                                          .map<DropdownMenuItem<int>>(
                                              (Product p) {
                                        return DropdownMenuItem<int>(
                                          key: UniqueKey(),
                                          value: p.id,
                                          child: Text(p.name),
                                        );
                                      }).toList(),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                              label: Text(
                                            translate("sale.lot"),
                                            style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          isExpanded: true,
                                          focusColor:
                                              Theme.of(context).primaryColor,
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          onChanged: (int? newValue) {
                                            Lot chosenLot = selectedProduct
                                                .lots!
                                                .singleWhere(
                                                    (l) => l.id == newValue);
                                            setState(() {
                                              selectedLot = chosenLot;
                                              BlocProvider.of<SaleOrderBloc>(
                                                      context)
                                                  .add(PatchSaleOrderLineEvent(
                                                      saleOrderID:
                                                          widget.saleOrderId,
                                                      saleOrderLineID: widget
                                                          .saleOrderLine.id,
                                                      updateData: {
                                                    "lot_id": selectedLot.id
                                                  }));
                                            });
                                          },
                                          value: selectedLot.id,
                                          items: selectedProduct.lots!
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
                            onFieldSubmitted: (value) {
                              BlocProvider.of<SaleOrderBloc>(context).add(
                                  PatchSaleOrderLineEvent(
                                      saleOrderID: widget.saleOrderId,
                                      saleOrderLineID: widget.saleOrderLine.id,
                                      updateData: {
                                    "name": nameContoller.text
                                  }));
                            },
                            style: const TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.normal),
                            cursorColor: Theme.of(context).primaryColor,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return translate("error.emptyText");
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: translate("sale.name"),
                              label: Text(
                                translate("sale.name"),
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 80.0, left: 15, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: SizedBox(
                                      width: width * 0.3,
                                      child: TextFormField(
                                        controller: priceController,
                                        onFieldSubmitted: (value) {
                                          BlocProvider.of<SaleOrderBloc>(
                                                  context)
                                              .add(PatchSaleOrderLineEvent(
                                                  saleOrderID:
                                                      widget.saleOrderId,
                                                  saleOrderLineID:
                                                      widget.saleOrderLine.id,
                                                  updateData: {
                                                "price": priceController.text
                                              }));
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return translate("error.emptyText");
                                          }
                                          return null;
                                        },
                                        cursorColor:
                                            Theme.of(context).primaryColor,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          hintText: translate("sale.price"),
                                          label: Text(
                                            translate("sale.price"),
                                            style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                                        onFieldSubmitted: (value) {
                                          BlocProvider.of<SaleOrderBloc>(
                                                  context)
                                              .add(PatchSaleOrderLineEvent(
                                                  saleOrderID:
                                                      widget.saleOrderId,
                                                  saleOrderLineID:
                                                      widget.saleOrderLine.id,
                                                  updateData: {
                                                "discount":
                                                    discountController.text
                                              }));
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return translate("error.emptyText");
                                          }
                                          return null;
                                        },
                                        cursorColor:
                                            Theme.of(context).primaryColor,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          hintText: translate("sale.discount"),
                                          label: Text(
                                            translate("sale.discount"),
                                            style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      onFieldSubmitted: (value) {
                                        BlocProvider.of<SaleOrderBloc>(context)
                                            .add(PatchSaleOrderLineEvent(
                                                saleOrderID: widget.saleOrderId,
                                                saleOrderLineID:
                                                    widget.saleOrderLine.id,
                                                updateData: {
                                              "tax": taxeContoller.text
                                            }));
                                      },
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        hintText: translate("sale.tax"),
                                        label: Text(
                                          translate("sale.tax"),
                                          style: const TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
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
                                        onFieldSubmitted: (value) {
                                          BlocProvider.of<SaleOrderBloc>(
                                                  context)
                                              .add(PatchSaleOrderLineEvent(
                                                  saleOrderID:
                                                      widget.saleOrderId,
                                                  saleOrderLineID:
                                                      widget.saleOrderLine.id,
                                                  updateData: {
                                                "quantity":
                                                    quantityContoller.text
                                              }));
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return translate("error.emptyText");
                                          }
                                          return null;
                                        },
                                        cursorColor:
                                            Theme.of(context).primaryColor,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          hintText: translate("sale.quantity"),
                                          label: Text(
                                            translate("sale.quantity"),
                                            style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
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
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                child: Text(translate("update")),
                                style: TextButton.styleFrom(
                                  minimumSize: const Size(100, 40),
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.deepPurple,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (_formKey.currentState!.validate() &&
                                      selectedProduct is Product) {
                                    LineData saleOrderLineData = LineData(
                                        id: widget.saleOrderLine.id,
                                        name: nameContoller.text,
                                        quantity:
                                            int.parse(quantityContoller.text),
                                        price:
                                            double.parse(priceController.text),
                                        product: selectedProduct,
                                        lot: selectedLot,
                                        discount: double.parse(
                                            discountController.text),
                                        taxe: double.parse(
                                          taxeContoller.text,
                                        ));

                                    BlocProvider.of<SaleOrderBloc>(context).add(
                                        UpdateSaleOrderLineEvent(
                                            saleorderID: widget.saleOrderId,
                                            saleorderLine: saleOrderLineData));
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        )));
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
}
