import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/manufacturing_product/bloc/manufacturing_product_bloc.dart';
import 'package:suppwayy_mobile/manufacturing_product/models/manufacturing_product_list_model.dart';

class ManufacturingProductDescriptionTab extends StatefulWidget {
  const ManufacturingProductDescriptionTab(
      {Key? key, required this.manufacturingProduct})
      : super(key: key);
  final ManufacturingProduct manufacturingProduct;
  @override
  State<ManufacturingProductDescriptionTab> createState() =>
      _ManufacturingProductDescriptionTabState();
}

class _ManufacturingProductDescriptionTabState
    extends State<ManufacturingProductDescriptionTab> {
  TextEditingController descriptionContorller = TextEditingController();
  @override
  void initState() {
    super.initState();
    descriptionContorller.text = widget.manufacturingProduct.description!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManufacturingProductBloc, ManufacturingProductState>(
      listener: (context, state) {
        if (state is ManufacturingProductUpdated) {
          BlocProvider.of<ManufacturingProductBloc>(context)
              .add(GetManufacturingProductsEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate("product.updatesuccess")),
            ),
          );
        } else if (state is UpdateManufacturingProductFailed) {
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
                Icons.check,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                BlocProvider.of<ManufacturingProductBloc>(context).add(
                    UpdateManufacturingProductEvent(
                        manufacturingProductId: widget.manufacturingProduct.id!,
                        updatedManufacturingProductData: {
                      "description": descriptionContorller.text,
                    }));
                Navigator.pop(context);
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
