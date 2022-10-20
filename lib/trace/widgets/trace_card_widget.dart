import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:suppwayy_mobile/trace/models/trace_history_model.dart';
import 'package:suppwayy_mobile/trace/traceability_result_page.dart';

class TraceCardWidget extends StatelessWidget {
  final TraceHistory trace;
  final int index;
  const TraceCardWidget({Key? key, required this.trace, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TraceProductResultPage(traceHistory: trace),
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(10.0),
          leading: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).backgroundColor.withOpacity(0.4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat("dd-MM-yyyy").format(
                    DateTime.parse(dateTime.toString()),
                  ),
                ),
                Text(
                  DateFormat("kk:mm").format(
                    DateTime.parse(dateTime.toString()),
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            trace.traceRequest.locationID,
          ),
          subtitle: trace.traceRequest.traceableItemID == ""
              ? Text(
                  "${translate('product.lot')}: ${trace.traceRequest.lotNumber} \n${translate('product.gtin')}: ${trace.traceRequest.gs1GTIN}",
                )
              : Text(
                  "${translate("product.traceableItemID")}: ${trace.traceRequest.traceableItemID}",
                ),
        ),
      ),
    );
  }
}
