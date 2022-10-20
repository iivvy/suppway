import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_list_model.dart';

class SaleOrderInfoTab extends StatefulWidget {
  const SaleOrderInfoTab({Key? key, required this.saleOrder}) : super(key: key);
  final SaleOrder saleOrder;
  @override
  State<SaleOrderInfoTab> createState() => _SaleOrderInfoTabState();
}

class _SaleOrderInfoTabState extends State<SaleOrderInfoTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20.0, right: 20.0),
      child: Column(
        children: [
          TextFormField(
            initialValue: widget.saleOrder.total.toStringAsFixed(2),
            readOnly: true,
            decoration: InputDecoration(
                labelText: translate(
                  "sale.total",
                ),
                labelStyle: Theme.of(context).textTheme.headline3),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: widget.saleOrder.taxes.toStringAsFixed(2),
            readOnly: true,
            decoration: InputDecoration(
                labelText: translate(
                  "sale.tax",
                ),
                labelStyle: Theme.of(context).textTheme.headline3),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: widget.saleOrder.taxedTotal.toStringAsFixed(2),
            readOnly: true,
            decoration: InputDecoration(
                labelText: translate(
                  "sale.taxedTotal",
                ),
                labelStyle: Theme.of(context).textTheme.headline3),
          ),
        ],
      ),
    );
  }
}
