import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';
import 'package:suppwayy_mobile/sale/models/line_data.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_list_model.dart';
import 'package:suppwayy_mobile/sale/widgets/sale_order_line_card_widget.dart';

import '../add_sale_order_line.dart';

class SaleOrderLineTab extends StatefulWidget {
  const SaleOrderLineTab({Key? key, required this.saleOrder}) : super(key: key);
  final SaleOrder saleOrder;
  @override
  State<SaleOrderLineTab> createState() => _SaleOrderLineTabState();
}

class _SaleOrderLineTabState extends State<SaleOrderLineTab> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Container(
                height: height * 0.05,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddSaleOrderLine(),
                      ),
                    );

                    if (result is LineData) {
                      BlocProvider.of<SaleOrderBloc>(context).add(
                          AddSaleOrderLineEvent(
                              saleOrderLineData: result,
                              saleOrderID: widget.saleOrder.id));
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                )),
          ),
        ),
        SizedBox(
          height: height * 0.30,
          child: ListView.builder(
            itemCount: widget.saleOrder.lines.saleOrderLines.length,
            itemBuilder: (context, index) => Center(
              child: SaleOrdeLineCardWidget(
                saleOrderLine: widget.saleOrder.lines.saleOrderLines[index],
                saleOrder: widget.saleOrder,
              ),
            ),
          ),
        )
      ],
    );
  }
}
