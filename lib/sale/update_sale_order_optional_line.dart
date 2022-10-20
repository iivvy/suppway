import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';

import 'models/sale_order_list_model.dart';
import 'models/sale_order_optional_line_model.dart';

class UpdateSaleOrderOptionalLineContainer extends StatefulWidget {
  const UpdateSaleOrderOptionalLineContainer(
      {Key? key, required this.saleOrder, required this.saleOrderOptionalLine})
      : super(key: key);
  final SaleOrder saleOrder;
  final SaleOrderOptionalLine saleOrderOptionalLine;

  @override
  State<UpdateSaleOrderOptionalLineContainer> createState() =>
      _UpdateSaleOrderOptionalLineContainerState();
}

class _UpdateSaleOrderOptionalLineContainerState
    extends State<UpdateSaleOrderOptionalLineContainer> {
  final _formKey = GlobalKey<FormState>();
  bool productSelected = false;
  late Product selectedProduct;
  TextEditingController discountController = TextEditingController();

  @override
  void initState() {
    selectedProduct = widget.saleOrderOptionalLine.product;
    discountController.text = widget.saleOrderOptionalLine.discount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("line.Updatetitle")),
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
                              BlocProvider.of<SaleOrderBloc>(context).add(
                                  PatchSaleOrderOptionalLineEvent(
                                      saleOrderId: widget.saleOrder.id,
                                      saleOrderOptionalLineId:
                                          widget.saleOrderOptionalLine.id!,
                                      updateData: {
                                    "product": selectedProduct.id
                                  }));
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
                    return Center(
                        child: Text(translate("line.errorLoadingOptional")));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                textInputAction: TextInputAction.send,
                controller: discountController,
                style: const TextStyle(
                    fontSize: 15.0,
                    // color: Colors.black,
                    fontWeight: FontWeight.normal),
                cursorColor: Theme.of(context).primaryColor,
                onFieldSubmitted: (value) {
                  BlocProvider.of<SaleOrderBloc>(context).add(
                      PatchSaleOrderOptionalLineEvent(
                          saleOrderId: widget.saleOrder.id,
                          saleOrderOptionalLineId:
                              widget.saleOrderOptionalLine.id!,
                          updateData: {"discount": discountController.text}));
                },
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
