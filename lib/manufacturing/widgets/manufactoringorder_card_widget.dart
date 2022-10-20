import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suppwayy_mobile/manufacturing/manufacturing_order_detail_page.dart';
import 'package:suppwayy_mobile/manufacturing/models/manufacturing_order_list_model.dart';

class ManufactoringOrderWidget extends StatelessWidget {
  ManufactoringOrderWidget({Key? key, required this.manufacturingOrder})
      : super(key: key);
  final ManufacturingOrder manufacturingOrder;
  final List<String> states = ["draft", "confirmed", "cancel"];

  @override
  Widget build(BuildContext context) {
    String status = manufacturingOrder.status.toLowerCase();
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ManufacturingOrderDetailPage(
                    manufacturingOrder: manufacturingOrder))),
        child: Row(
          children: [
            Container(
              height: 70.0,
              width: 10.0,
              color: status == states[0]
                  ? Colors.orange.shade600
                  : status == states[1]
                      ? Colors.green
                      : Colors.grey.shade600,
            ),
            Flexible(
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                title: Text(manufacturingOrder.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat("dd / MM / yyyy").format(
                          DateTime.parse(manufacturingOrder.date.toString())),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
