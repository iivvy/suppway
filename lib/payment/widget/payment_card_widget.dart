import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/payment/model/payment_list_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({Key? key, required this.payment}) : super(key: key);
  final Payment payment;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 2.0,
        shadowColor: Colors.indigo,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: const Alignment(-1.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translate("payment.Billing"),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        translate("payment.amount") +
                            " :"
                                "${payment.amount.toStringAsFixed(2)}",
                      ),
                    ],
                  )),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(payment.name),
                  Text(payment.email),
                  Text(payment.phone),
                ],
              ),
            )),
            const Divider(
              color: Colors.black38,
            ),
            InkWell(
              onTap: () => _launchInBrowser(payment.reciept),
              child: Text(
                translate("payment.receipt"),
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
