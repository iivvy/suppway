import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suppwayy_mobile/manufacturing/bloc/manufacturing_order_bloc.dart';
import 'package:suppwayy_mobile/manufacturing/models/manufacturing_order_line_list_model.dart';
import 'package:suppwayy_mobile/manufacturing/models/manufacturing_order_list_model.dart';
import 'package:suppwayy_mobile/manufacturing/update_manufacturing_order_line_detail_page.dart';

import '../../product/bloc/product_bloc.dart';

class ManufacturingOrderLineCard extends StatefulWidget {
  const ManufacturingOrderLineCard(
      {Key? key,
      required this.manufacturingOrder,
      required this.manufacturingOrderLine
      })
      : super(key: key);
  final ManufacturingOrder manufacturingOrder;
  final ManufacturingOrderLine manufacturingOrderLine;

  @override
  State<ManufacturingOrderLineCard> createState() =>
      _ManufacturingOrderLineCard();
}

class _ManufacturingOrderLineCard extends State<ManufacturingOrderLineCard> {
  @override
  Widget build(BuildContext context) {
    // Image productImage = widget.manufacturingOrderLine.product.image!.isNotEmpty
    //     ? Image.network(
    //     "${SuppWayy.baseUrl}/${widget.manufacturingOrderLine.product.image}",
    //     headers: BlocProvider.of<ProductBloc>(context)
    //         .productsService
    //         .getHeadersWithAuthorization)
    Image.asset(
      "assets/images/avatar.png",
      color: Theme.of(context).iconTheme.color,
      height: 70,
    );
    return Card(
        child: InkWell(
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateManufacturingOrderLinePage())),

      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
        trailing: PopupMenuButton(
          icon: const Icon(
            Icons.more_vert,
            size: 25,
          ),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Row(

                  children: const [

                    Icon(Icons.delete),
                    Text('delete'),
                  ],
                ),
              ),
            ];
          },
          onSelected: (value){
            BlocProvider.of<ManufacturingOrderBloc>(context).add(
              DeleteManufacturingOrderLineEvent(manufacturingOrderID: widget.manufacturingOrder.id!, manufacturingOrderLineID: widget.manufacturingOrderLine.id));

          },
        ),
        title: Text('quantity',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
        subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('display something here'),
                    Text('another thing here'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('asas'),
                      ],
                    )
                  ],
                )
              ],
            ),

          ],
        ),
      ),
    ));
  }
}
