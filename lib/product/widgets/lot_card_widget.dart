import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:intl/intl.dart';
import 'package:suppwayy_mobile/lot/bloc/lot_bloc.dart';
import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';
import 'package:suppwayy_mobile/product/product_lot_update_page.dart';

class LotCardWidget extends StatefulWidget {
  const LotCardWidget({Key? key, required this.lot, required this.product})
      : super(key: key);
  final Lot lot;
  final Product product;
  @override
  _LotCardWidgetState createState() => _LotCardWidgetState();
}

class _LotCardWidgetState extends State<LotCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductLotUpdatePage(
            product: widget.product,
            lot: widget.lot,
          ),
        ),
      ),
      child: Card(
        elevation: 2,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).secondaryHeaderColor),
            child: Center(
              child: Text(
                widget.lot.quantity.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ),
          ),
          trailing: PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                size: 20,
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<int>(
                    height: 15,
                    value: 0,
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        Text(translate("lot.delete")),
                      ],
                    ),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  BlocProvider.of<LotBloc>(context).add(DeletelotEvent(
                      lotID: widget.lot.id, productID: widget.product.id!));
                }
              }),
          title: Text(
            widget.lot.reference,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          subtitle: Text(
            DateFormat("dd / MM / yyyy")
                .format(DateTime.parse(widget.lot.date.toString())),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ),
      ),
    );
  }
}
