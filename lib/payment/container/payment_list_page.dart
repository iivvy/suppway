import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/profile/bloc/bloc/profile_bloc.dart';
import 'package:suppwayy_mobile/payment/model/payment_list_model.dart';
import 'package:suppwayy_mobile/payment/widget/payment_card_widget.dart';

import '../bloc/payment_bloc.dart';

class PaymentListPage extends StatelessWidget {
  const PaymentListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(listener: (context, state) {
      if (state is DeAuthorizeSuccess) {
        BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            //votre compte a été autorisé
            content: Text(translate("payment.accountDeAuthorized")),
          ),
        );
      }
    }, builder: (context, state) {
      if (state is PaymentListloaded) {
        return ListView.builder(
            itemCount: state.paymentList.length,
            itemBuilder: (context, index) {
              Payment payment = state.paymentList[index];

              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(child: PaymentCard(payment: payment)),
              );
            });
      } else if (state is PaymentError) {
        return Center(child: Text(state.error));
      } else {
        return Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ));
      }
    });
  }
}
