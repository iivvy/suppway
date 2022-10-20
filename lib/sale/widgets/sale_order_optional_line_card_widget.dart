import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';

import 'package:suppwayy_mobile/sale/models/sale_order_list_model.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_optional_line_model.dart';
import 'package:suppwayy_mobile/sale/update_sale_order_optional_line.dart';

import '../../suppwayy_config.dart';

class SaleOrdeOptionalLineCardWidget extends StatefulWidget {
  const SaleOrdeOptionalLineCardWidget(
      {Key? key, required this.saleOrder, required this.saleOrderOptionalLine})
      : super(key: key);
  final SaleOrder saleOrder;
  final SaleOrderOptionalLine saleOrderOptionalLine;
  @override
  _SaleOrdeOptionalLineCardWidgetState createState() =>
      _SaleOrdeOptionalLineCardWidgetState();
}

class _SaleOrdeOptionalLineCardWidgetState
    extends State<SaleOrdeOptionalLineCardWidget> {
  @override
  Widget build(BuildContext context) {
    Image productImage = widget.saleOrderOptionalLine.product.image!.isNotEmpty
        ? Image.network(
            "${SuppWayy.baseUrl}/${widget.saleOrderOptionalLine.product.image}",
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
          builder: (context) => UpdateSaleOrderOptionalLineContainer(
              saleOrderOptionalLine: widget.saleOrderOptionalLine,
              saleOrder: widget.saleOrder),
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
                  BlocProvider.of<SaleOrderBloc>(context).add(
                      DeleteOptionalLine(
                          saleOrderId: widget.saleOrder.id,
                          optionalLineId: widget.saleOrderOptionalLine.id!));
                }
              }),
          title: Text(
            widget.saleOrderOptionalLine.product.name.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    translate("sale.price") + " : ",
                  ),
                  Text(
                    widget.saleOrderOptionalLine.product.standardprice
                        .toString(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    translate("sale.discount") + " : ",
                  ),
                  Text(
                    widget.saleOrderOptionalLine.discount.toString(),
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
