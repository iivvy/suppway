import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';
import 'package:suppwayy_mobile/partner/bloc/partner_bloc.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';
import 'package:suppwayy_mobile/sale/containers/update_saleorder_partner.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_list_model.dart';

import '../../suppwayy_config.dart';

class UpdatePartnerCardWidget extends StatefulWidget {
  const UpdatePartnerCardWidget({
    Key? key,
    required this.saleOrder,
    required this.setSelectedPartner,
  }) : super(key: key);
  final SaleOrder saleOrder;
  final ValueChanged setSelectedPartner;

  @override
  State<UpdatePartnerCardWidget> createState() =>
      _UpdatePartnerCardWidgetState();
}

class _UpdatePartnerCardWidgetState extends State<UpdatePartnerCardWidget> {
  static LocationListModel location = const LocationListModel();

  Partner buyer = Partner(
      id: 0,
      name: "",
      phone: "",
      address: "",
      email: "",
      website: "",
      locations: location,
      photo: '',
      stripeId: '',
      status: '');
  List<Location> locationListPartner = [];
  int deliverylocation = 0;
  @override
  void initState() {
    deliverylocation = widget.saleOrder.deliveryLocation.id!;
    locationListPartner = widget.saleOrder.buyer.locations!.locations;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Image partnerImage = widget.saleOrder.buyer.photo.isNotEmpty
        ? Image.network("${SuppWayy.baseUrl}/${widget.saleOrder.buyer.photo}",
            headers: BlocProvider.of<PartnerBloc>(context)
                .partnersService
                .getHeadersWithAuthorization)
        : Image.asset(
            "assets/images/avatar.png",
            color: Theme.of(context).iconTheme.color,
            height: 70,
          );
    return Card(
        child: ListTile(
      title: InkWell(
        onTap: () async {
          var returned = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdateSaleOrderPartner()),
          );
          if (returned is Partner) {
            setState(() {
              buyer = returned;
              widget.setSelectedPartner(buyer);
            });
          }
          BlocProvider.of<SaleOrderBloc>(context).add(PatchSaleOrderEvent(
              saleOrderID: widget.saleOrder.id,
              updateData: {"buyer_id": returned.id}));
        },
        child: Text(
          widget.saleOrder.buyer.name,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      subtitle: InkWell(
        onTap: () {},
        child: Container(
          height: 30,
          // width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.email,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(widget.saleOrder.buyer.email,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 10.0)),
            ],
          ),
        ),
      ),
      leading: InkWell(
        onTap: () async {
          var returned = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdateSaleOrderPartner()),
          );

          if (returned is Partner) {
            setState(() {
              buyer = returned;
              widget.setSelectedPartner(buyer);
            });
          }
          BlocProvider.of<SaleOrderBloc>(context).add(PatchSaleOrderEvent(
              saleOrderID: widget.saleOrder.id,
              updateData: {"buyer_id": returned.id}));
        },
        child: Container(
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
      ),
    ));
  }
}
