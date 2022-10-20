import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';

import 'models/sale_order_list_model.dart';
import 'models/sale_order_optional_line_model.dart';

class AddOptionalLines extends StatefulWidget {
  const AddOptionalLines({Key? key, required this.saleOrder}) : super(key: key);
  final SaleOrder saleOrder;
  @override
  State<AddOptionalLines> createState() => _AddOptionalLinesState();
}

class _AddOptionalLinesState extends State<AddOptionalLines> {
  final _formKey = GlobalKey<FormState>();
  bool productSelected = false;
  late Product selectedProduct;
  TextEditingController discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<SaleOrderBloc>(context).add(
                  AddSaleOrderOptionalLineEvent(
                    saleOrderID: widget.saleOrder.id,
                    saleOrderOptionalLineData: SaleOrderOptionalLine(
                      discount: double.parse(discountController.text),
                      product: selectedProduct,
                    ),
                  ),
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 20),
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
                controller: discountController,
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
                  hintText: translate("sale.discount"),
                  label: Text(translate("sale.discount")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
