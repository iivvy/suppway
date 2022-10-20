import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';

class ProductDataTab extends StatefulWidget {
  const ProductDataTab({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  State<ProductDataTab> createState() => _ProductDataTabState();
}

class _ProductDataTabState extends State<ProductDataTab> {
  TextEditingController volume = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController standarPrice = TextEditingController();
  TextEditingController taxe = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    volume.text = widget.product.volume.toString();
    quantity.text = widget.product.quantity.toString();
    standarPrice.text = widget.product.standardprice.toString();
    taxe.text = widget.product.taxe.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is PatchSuccess) {
          BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate("product.updatesuccess")),
            ),
          );
        } else if (state is PatchError) {
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
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Column(
              children: [
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
                      BlocProvider.of<ProductBloc>(context).add(PatchProduct(
                          productId: widget.product.id!,
                          updatedProductData: {'volume': volume.text}));
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.send,
                  controller: quantity,
                  decoration: InputDecoration(
                    hintText: translate("product.quantity"),
                    labelText: translate("product.quantity"),
                  ),
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ProductBloc>(context).add(PatchProduct(
                          productId: widget.product.id!,
                          updatedProductData: {'quantity': quantity.text}));
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.send,
                  controller: standarPrice,
                  decoration: InputDecoration(
                    hintText: translate("product.standarPrice"),
                    labelText: translate("product.standarPrice"),
                  ),
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ProductBloc>(context).add(PatchProduct(
                          productId: widget.product.id!,
                          updatedProductData: {
                            'standardprice': standarPrice.text
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
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.send,
                  controller: taxe,
                  decoration: InputDecoration(
                    hintText: translate("product.taxe"),
                    labelText: translate("product.taxe"),
                  ),
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ProductBloc>(context).add(PatchProduct(
                          productId: widget.product.id!,
                          updatedProductData: {'taxe': taxe.text}));
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
