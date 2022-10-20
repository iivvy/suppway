import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suppwayy_mobile/deliveries/model/deliveries_list_model.dart';

import '../sale_delivery_details_page.dart';

class SaleDeliveryCard extends StatelessWidget {
  SaleDeliveryCard({Key? key, required this.delivery}) : super(key: key);
  final Delivery delivery;
  final List<String> stateList = [
    "NOT_READY",
    "READY",
    "IN_PROGRESS",
    "DELIVERED"
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String status = delivery.state;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SaleDeliveryDetailsPage(delivery: delivery),
          ),
        );
      },
      child: Card(
        elevation: 2,
        child: Row(
          children: [
            Container(
              height: 70.0,
              width: width * 0.025,
              color: status == stateList[0]
                  ? Colors.grey.shade400
                  : status == stateList[1]
                      ? Colors.amberAccent[400]
                      : status == stateList[2]
                          ? Colors.orange.shade600
                          : Colors.green,
            ),
            SizedBox(
              width: width * 0.9,
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                title: Text(
                  DateFormat.yMd().format(delivery.date),
                ),
                subtitle: Text(
                  delivery.signatureMethod,
                  style: Theme.of(context).textTheme.headline4,
                ),
                trailing: Text(
                  delivery.state,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
