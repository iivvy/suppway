import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/profile/bloc/bloc/profile_bloc.dart';
import 'package:suppwayy_mobile/payment/stripe_webview_page.dart';

import '../bloc/payment_bloc.dart';

class PaymentAuthorizePage extends StatefulWidget {
  const PaymentAuthorizePage({Key? key}) : super(key: key);

  @override
  State<PaymentAuthorizePage> createState() => _PaymentAuthorizePageState();
}

class _PaymentAuthorizePageState extends State<PaymentAuthorizePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(listener: (context, state) {
      if (state is AuthorizeSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StripeWebViewPage(url: state.uri),
          ),
        );
      } else if (state is PaymentError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
            duration: const Duration(seconds: 5),
          ),
        );
      } else if (state is AuthorizeRetrunSuccess) {
        BlocProvider.of<PaymentBloc>(context)
            .add(const GetPaymentList(limitListPayment: 100));
        BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            //votre compte a été autorisé
            content: Text(translate("payment.accountAuthorized")),
          ),
        );
      }
    }, builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              translate(
                "profile.textauthorize",
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).backgroundColor),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<PaymentBloc>(context).add(PaymentAuthorize());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/stripeAuthorize.png",
                    color: Theme.of(context).bottomAppBarColor,
                    height: 30,
                  ),
                  Text(translate("payment.authorize")),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor.withOpacity(0.8),
                  fixedSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
        ],
      );
    });
  }
}
