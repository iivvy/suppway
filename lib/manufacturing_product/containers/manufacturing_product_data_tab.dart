import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/manufacturing_product/bloc/manufacturing_product_bloc.dart';
import 'package:suppwayy_mobile/manufacturing_product/models/manufacturing_product_list_model.dart';

class ManufacturingProductDataTab extends StatefulWidget {
  const ManufacturingProductDataTab(
      {Key? key, required this.manufacturingProduct})
      : super(key: key);
  final ManufacturingProduct manufacturingProduct;
  @override
  State<ManufacturingProductDataTab> createState() =>
      _ManufacturingProductDataTabState();
}

class _ManufacturingProductDataTabState
    extends State<ManufacturingProductDataTab> {
  TextEditingController volume = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController standarPrice = TextEditingController();
  TextEditingController taxe = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    volume.text = widget.manufacturingProduct.volume.toString();
    quantity.text = widget.manufacturingProduct.quantity.toString();
    standarPrice.text = widget.manufacturingProduct.standardprice.toString();
    taxe.text = widget.manufacturingProduct.taxe.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManufacturingProductBloc, ManufacturingProductState>(
      listener: (context, state) {
        if (state is ManufacturingProductUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate("product.updatesuccess")),
            ),
          );
        } else if (state is UpdateManufacturingProductFailed) {
          BlocProvider.of<ManufacturingProductBloc>(context)
              .add(GetManufacturingProductsEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate("product.updatefailed")),
            ),
          );
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.send,
                  keyboardType: TextInputType.number,
                  controller: standarPrice,
                  decoration: InputDecoration(
                    hintText: translate("product.standarPrice"),
                    labelText: translate("product.standarPrice"),
                  ),
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ManufacturingProductBloc>(context).add(
                          UpdateManufacturingProductEvent(
                              manufacturingProductId:
                                  widget.manufacturingProduct.id!,
                              updatedManufacturingProductData: {
                            "standardprice": standarPrice.text
                          }));
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textInputAction: TextInputAction.send,
                  keyboardType: TextInputType.number,
                  controller: quantity,
                  decoration: InputDecoration(
                    hintText: translate("product.quantity"),
                    labelText: translate("product.quantity"),
                  ),
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ManufacturingProductBloc>(context).add(
                          UpdateManufacturingProductEvent(
                              manufacturingProductId:
                                  widget.manufacturingProduct.id!,
                              updatedManufacturingProductData: {
                            "quantity": quantity.text
                          }));
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textInputAction: TextInputAction.send,
                  keyboardType: TextInputType.number,
                  controller: taxe,
                  decoration: InputDecoration(
                    hintText: translate("product.taxe"),
                    labelText: translate("product.taxe"),
                  ),
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ManufacturingProductBloc>(context).add(
                          UpdateManufacturingProductEvent(
                              manufacturingProductId:
                                  widget.manufacturingProduct.id!,
                              updatedManufacturingProductData: {
                            "taxe": taxe.text
                          }));
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textInputAction: TextInputAction.send,
                  keyboardType: TextInputType.number,
                  controller: volume,
                  decoration: InputDecoration(
                    hintText: translate("product.volume"),
                    labelText: translate("product.volume"),
                  ),
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ManufacturingProductBloc>(context).add(
                          UpdateManufacturingProductEvent(
                              manufacturingProductId:
                                  widget.manufacturingProduct.id!,
                              updatedManufacturingProductData: {
                            "volume": volume.text
                          }));
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
