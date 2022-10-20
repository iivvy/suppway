import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';
import 'package:suppwayy_mobile/sale/containers/update_saleorder_partner.dart';

class AddPartnerCardWidget extends StatefulWidget {
  const AddPartnerCardWidget({
    Key? key,
    required this.setSelectedPartner,
  }) : super(key: key);

  final ValueChanged setSelectedPartner;
  @override
  State<AddPartnerCardWidget> createState() => _AddPartnerCardWidgetState();
}

class _AddPartnerCardWidgetState extends State<AddPartnerCardWidget> {
  static LocationListModel location = const LocationListModel();

  Partner selectedPartner = Partner(
      id: -1,
      name: translate("sale.partnerName"),
      phone: translate("partner.phone"),
      address: translate("partner.address"),
      email: translate("partner.mail"),
      website: "",
      locations: location,
      photo: '',
      stripeId: '',
      status: '');
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      onTap: () async {
        var returned = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const UpdateSaleOrderPartner()),
        );
        if (returned is Partner) {
          setState(() {
            selectedPartner = returned;
            widget.setSelectedPartner(selectedPartner);
          });
        }
      },
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          selectedPartner.name,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                selectedPartner.phone,
              ),
            ),
            Flexible(
              child: Text(
                selectedPartner.email,
              ),
            ),
            Flexible(
              child: Text(
                selectedPartner.address,
              ),
            ),
          ],
        ),
      ),
      leading: const Icon(
        Icons.person,
        size: 40,
      ),
    ));
  }
}
