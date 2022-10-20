import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';

class ProductDescriptionTab extends StatefulWidget {
  const ProductDescriptionTab({Key? key, required this.product})
      : super(key: key);
  final Product product;
  @override
  State<ProductDescriptionTab> createState() => _ProductDescriptionTabState();
}

class _ProductDescriptionTabState extends State<ProductDescriptionTab> {
  TextEditingController descriptionContorller = TextEditingController();

  @override
  void initState() {
    descriptionContorller.text = widget.product.description!;
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
      child: Container(
        padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
        child: TextField(
          keyboardType: TextInputType.multiline,
          textAlignVertical: TextAlignVertical.top,
          maxLines: null,
          minLines: 10,
          controller: descriptionContorller,
          decoration: InputDecoration(
            suffix: IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                BlocProvider.of<ProductBloc>(context).add(PatchProduct(
                    productId: widget.product.id!,
                    updatedProductData: {
                      "description": descriptionContorller.text,
                    }));
              },
            ),
            hintText: translate("product.Description"),
            hintStyle: const TextStyle(color: Colors.grey),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.blueGrey[100]!),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
