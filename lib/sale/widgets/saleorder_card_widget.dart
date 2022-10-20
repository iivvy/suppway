import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:suppwayy_mobile/partner/bloc/partner_bloc.dart';

import 'package:suppwayy_mobile/sale/models/sale_order_list_model.dart';
import 'package:suppwayy_mobile/sale/sale_order_detail_page.dart';

import '../../suppwayy_config.dart';

class SaleOrderCardWidget extends StatelessWidget {
  SaleOrderCardWidget({Key? key, required this.saleOrder}) : super(key: key);
  final SaleOrder saleOrder;
  final List<String> states = ["draft", "confirmed", "cancel"];
  @override
  Widget build(BuildContext context) {
    String status = saleOrder.status.toLowerCase();
    Image partnerImage = saleOrder.buyer.photo.isNotEmpty
        ? Image.network("${SuppWayy.baseUrl}/${saleOrder.buyer.photo}",
            headers: BlocProvider.of<PartnerBloc>(context)
                .partnersService
                .getHeadersWithAuthorization)
        : Image.asset(
            "assets/images/avatar.png",
            color: Theme.of(context).iconTheme.color,
            height: 70,
          );
    return Card(
      child: InkWell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SaleOrderDetailPage(saleOrder: saleOrder),
                ),
              ),
          child: Row(
            children: [
              Container(
                height: 70.0,
                width: 10.0,
                color: status == states[0]
                    ? Colors.orange.shade600
                    : status == states[1]
                        ? Colors.green
                        : Colors.grey.shade400,
              ),
              Flexible(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: partnerImage.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    saleOrder.name,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        saleOrder.buyer.name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        DateFormat("dd / MM / yyyy")
                            .format(DateTime.parse(saleOrder.date.toString())),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                  trailing: Text(
                    saleOrder.taxedTotal.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
