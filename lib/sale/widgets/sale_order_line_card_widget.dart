import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';

import 'package:suppwayy_mobile/sale/models/sale_order_line_list_model.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_list_model.dart';

import '../../suppwayy_config.dart';
import '../update_sale_order_line.dart';

class SaleOrdeLineCardWidget extends StatefulWidget {
  const SaleOrdeLineCardWidget(
      {Key? key, required this.saleOrder, required this.saleOrderLine})
      : super(key: key);
  final SaleOrder saleOrder;
  final SaleOrderLine saleOrderLine;
  @override
  _SaleOrdeLineCardWidgetState createState() => _SaleOrdeLineCardWidgetState();
}

class _SaleOrdeLineCardWidgetState extends State<SaleOrdeLineCardWidget> {
  @override
  Widget build(BuildContext context) {
    Image productImage = widget.saleOrderLine.product.image!.isNotEmpty
        ? Image.network(
            "${SuppWayy.baseUrl}/${widget.saleOrderLine.product.image}",
            headers: BlocProvider.of<ProductBloc>(context)
                .productsService
                .getHeadersWithAuthorization)
        : Image.asset(
            "assets/images/avatar.png",
            color: Theme.of(context).iconTheme.color,
            height: 70,
          );
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateSaleOrderLineContainer(
              saleOrderLine: widget.saleOrderLine,
              saleOrderId: widget.saleOrder.id),
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
              image: DecorationImage(
                image: productImage.image,
                fit: BoxFit.cover,
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
                  BlocProvider.of<SaleOrderBloc>(context)
                      .add(DeleteSaleOrderLineEvent(
                    saleorderID: widget.saleOrder.id,
                    saleorderLineID: widget.saleOrderLine.id,
                  ));
                }
              }),
          title: Text(
            widget.saleOrderLine.name.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translate("sale.tax") + " : ",
                      ),
                      Text(
                        widget.saleOrderLine.taxe.toString(),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(translate("sale.total") + " : "),
                          Text(
                            widget.saleOrderLine.total.toStringAsFixed(2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Text(translate("Taxed Total") + " : "),
                      Text(
                        widget.saleOrderLine.taxedTotal.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
