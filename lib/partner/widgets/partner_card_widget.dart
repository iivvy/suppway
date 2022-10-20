import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:suppwayy_mobile/partner/bloc/partner_bloc.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';
import '../../suppwayy_config.dart';
import '../partner_details_page.dart';

class PartnerCardWidget extends StatelessWidget {
  const PartnerCardWidget({Key? key, required this.partner}) : super(key: key);
  final Partner partner;

  @override
  Widget build(BuildContext context) {
    Image partnerImage = partner.photo.isNotEmpty
        ? Image.network("${SuppWayy.baseUrl}/${partner.photo}",
            headers: BlocProvider.of<PartnerBloc>(context)
                .partnersService
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
          builder: (context) => PartnerDetailsPage(
            partner: partner,
          ),
        ),
      ),
      child: Card(
        elevation: 2.0,
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
                image: partnerImage.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              partner.name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              partner.email,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
          trailing: ElevatedButton(
            onPressed: () {
              launchUrl(Uri.parse("tel://${partner.phone}"));
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
              primary: Color(0xff44A07E), // <-- Button color
              onPrimary: Colors.white, // <-- Splash color
            ),
            child: const Icon(
              Icons.phone,
            ),
          ),
        ),
      ),
    );
  }
}
