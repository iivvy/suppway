import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_list_model.dart';

class SaleOrderCommentTab extends StatefulWidget {
  const SaleOrderCommentTab({Key? key, required this.saleOrder})
      : super(key: key);
  final SaleOrder saleOrder;

  @override
  State<SaleOrderCommentTab> createState() => _SaleOrderCommentTabState();
}

class _SaleOrderCommentTabState extends State<SaleOrderCommentTab> {
  TextEditingController commentContorller = TextEditingController();

  @override
  void initState() {
    commentContorller.text = widget.saleOrder.comment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
      child: TextField(
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        maxLines: null,
        minLines: 9,
        controller: commentContorller,
        decoration: InputDecoration(
          suffix: IconButton(
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              BlocProvider.of<SaleOrderBloc>(context).add(PatchSaleOrderEvent(
                  saleOrderID: widget.saleOrder.id,
                  updateData: {
                    "comment": commentContorller.text,
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
    );
  }
}
