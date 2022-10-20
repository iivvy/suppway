import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suppwayy_mobile/deliveries/bloc/deliveries_bloc.dart';
import 'package:suppwayy_mobile/deliveries/model/deliveries_line_model.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';

import '../../suppwayy_config.dart';

class SaleDeliveryLineCardWidget extends StatefulWidget {
  const SaleDeliveryLineCardWidget({
    Key? key,
    required this.deliveryLines,
    required this.deliveryId,
    required this.checkGTIN,
  }) : super(key: key);
  final DeliveryLines deliveryLines;
  final int deliveryId;
  final String checkGTIN;
  @override
  State<SaleDeliveryLineCardWidget> createState() =>
      _SaleDeliveryLineCardWidgetState();
}

class _SaleDeliveryLineCardWidgetState
    extends State<SaleDeliveryLineCardWidget> {
  late int quantity;
  TextEditingController quantityController = TextEditingController(text: "1");
  @override
  void initState() {
    quantity = widget.deliveryLines.quantity;
    quantityController = TextEditingController(text: quantity.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Image productImage = widget.deliveryLines.product.image != ""
        ? Image.network(
            "${SuppWayy.baseUrl}/${widget.deliveryLines.product.image}",
            headers: BlocProvider.of<ProductBloc>(context)
                .productsService
                .getHeadersWithAuthorization,
          )
        : Image.asset(
            "assets/images/productImage.jpg",
          );
    if (widget.deliveryLines.product.gtin == widget.checkGTIN) {
      quantity++;
      setState(() {
        quantityController = TextEditingController(text: quantity.toString());
      });
      BlocProvider.of<DeliveriesBloc>(context).add(PatchDeliveryLineEvent(
        deliveryLineId: widget.deliveryLines.id,
        deliveryId: widget.deliveryId,
        updateData: {"quantity": quantity},
      ));
    }
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            leading: SizedBox(
              width: 100,
              height: 100,
              child: productImage,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                widget.deliveryLines.product.name,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            subtitle: Center(
              child: Container(
                width: 100,
                height: 25,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).backgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30,
                      color: Theme.of(context).backgroundColor.withOpacity(0.4),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            setState(() {
                              if (quantity > 0) {
                                quantity--;
                              }

                              quantityController = TextEditingController(
                                  text: quantity.toString());
                            });
                            BlocProvider.of<DeliveriesBloc>(context)
                                .add(PatchDeliveryLineEvent(
                              deliveryLineId: widget.deliveryLines.id,
                              deliveryId: widget.deliveryId,
                              updateData: {"quantity": quantity},
                            ));
                          },
                          icon: Icon(
                            Icons.remove,
                            size: 17,
                          )),
                    ),
                    SizedBox(
                        width: 30,
                        child: Center(
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            textInputAction: TextInputAction.send,
                            controller: quantityController,
                            style: Theme.of(context).textTheme.headline4,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            onFieldSubmitted: (value) {
                              BlocProvider.of<DeliveriesBloc>(context)
                                  .add(PatchDeliveryLineEvent(
                                deliveryLineId: widget.deliveryLines.id,
                                deliveryId: widget.deliveryId,
                                updateData: {"quantity": quantity},
                              ));
                            },
                          ),
                        )),
                    Container(
                      width: 30,
                      color: Theme.of(context).backgroundColor.withOpacity(0.4),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            setState(() {
                              quantity++;
                              quantityController = TextEditingController(
                                  text: quantity.toString());
                            });
                            BlocProvider.of<DeliveriesBloc>(context)
                                .add(PatchDeliveryLineEvent(
                              deliveryLineId: widget.deliveryLines.id,
                              deliveryId: widget.deliveryId,
                              updateData: {"quantity": quantity},
                            ));
                          },
                          icon: Icon(
                            Icons.add,
                            size: 17,
                          )),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
