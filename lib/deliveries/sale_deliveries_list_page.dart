import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/deliveries/bloc/deliveries_bloc.dart';
import 'package:suppwayy_mobile/deliveries/widget/sale_delivery_card_widget.dart';
import 'package:suppwayy_mobile/setting/bloc/setting_bloc.dart';
import 'package:suppwayy_mobile/setting/linear_gradient.dart';

import 'add_sale_delivery.dart';

class DeliveriesPage extends StatefulWidget {
  const DeliveriesPage({Key? key}) : super(key: key);

  @override
  State<DeliveriesPage> createState() => _DeliveriesPageState();
}

class _DeliveriesPageState extends State<DeliveriesPage> {
  late bool _theme;
  @override
  void initState() {
    BlocProvider.of<DeliveriesBloc>(context).add(GetDeliveriesEvent());
    _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("deliveries.title")),
      ),
      body: BlocConsumer<DeliveriesBloc, DeliveriesState>(
        listener: (context, state) {
          if (state is AddSaleDeliverySuccess) {
            BlocProvider.of<DeliveriesBloc>(context).add(GetDeliveriesEvent());
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("deliveries.createsuccess")),
              ),
            );
          }
          if (state is AddSaleDeliveryFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("deliveries.createfailed")),
              ),
            );
          }
          if (state is DeliveryDeleted) {
            BlocProvider.of<DeliveriesBloc>(context).add(GetDeliveriesEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("deliveries.deletesuccess")),
              ),
            );
          }
          if (state is DeliveryDeletedFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("deliveries.deletefailed")),
              ),
            );
          }
          if (state is DeliveryUpdated) {
            BlocProvider.of<DeliveriesBloc>(context).add(GetDeliveriesEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("deliveries.updatesuccess")),
              ),
            );
          }
          if (state is DeliveryUpdatedFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("deliveries.updatefailed")),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DeliveriesLoaded) {
            return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                scrollDirection: Axis.vertical,
                itemCount: state.deliveries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: ValueKey(state.deliveries[index]),
                    onDismissed: (direction) =>
                        BlocProvider.of<DeliveriesBloc>(context).add(
                            DeleteDelivery(
                                deliveryId: state.deliveries[index].id!)),
                    child: SaleDeliveryCard(
                      delivery: state.deliveries[index],
                    ),
                  );
                });
          } else if (state is DeliveriesLoadedError) {
            return Text(state.error);
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddSaleDelivery(),
            ),
          );
        },
        child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: colorGradient(_theme),
            ),
            child: const Icon(Icons.add)),
      ),
    );
  }
}
