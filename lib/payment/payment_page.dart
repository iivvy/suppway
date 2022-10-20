import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/profile/bloc/bloc/profile_bloc.dart';
import 'package:suppwayy_mobile/commons/drawer_widget.dart';
import 'package:suppwayy_mobile/payment/bloc/payment_bloc.dart';

import 'container/payment_authorize_page.dart';
import 'container/payment_list_page.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("payment.payments")),
        actions: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                String stripeId = state.partner.stripeId;
                if (stripeId != "") {
                  return PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert,
                      size: 30,
                    ),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<int>(
                            value: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/images/stripeDeAuthorize.png",
                                  height: 30,
                                ),
                                Text(
                                  translate("payment.deauthorize"),
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ],
                            )),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 0) {
                        showDeleteAlert(context);
                      }
                    },
                  );
                }
              }
              return Container();
            },
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileLoaded) {
          String stripeId = state.partner.stripeId;
          if (stripeId == "") {
            return const Padding(
                padding: EdgeInsets.all(0), child: PaymentAuthorizePage());
          } else {
            BlocProvider.of<PaymentBloc>(context)
                .add(const GetPaymentList(limitListPayment: 100));
            return const Padding(
                padding: EdgeInsets.all(0), child: PaymentListPage());
          }
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }

  void showDeleteAlert(BuildContext context) async {
    await showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Text(translate("payment.confirmDeAuthorize")),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("Ok"),
            onPressed: () {
              BlocProvider.of<PaymentBloc>(context).add(PaymentDeAuthorize());
              Navigator.of(context).pop();
              // setState(() => authorize = !authorize);
            },
          ),
          CupertinoDialogAction(
            child: Text(translate("sale.button.cancel")),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
