import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/manufacturing/add_manufacturing_order_page.dart';
import 'package:suppwayy_mobile/manufacturing/bloc/manufacturing_order_bloc.dart';
import 'package:suppwayy_mobile/manufacturing/models/manufacturing_order_list_model.dart';
import 'package:suppwayy_mobile/manufacturing/update_manufacturing_order_line_detail_page.dart';
import 'package:suppwayy_mobile/manufacturing/widgets/manufactoringorder_card_widget.dart';
import 'package:suppwayy_mobile/setting/bloc/setting_bloc.dart';
import 'package:suppwayy_mobile/setting/linear_gradient.dart';

class ManufacturingOrderPage extends StatefulWidget {
  const ManufacturingOrderPage({Key? key}) : super(key: key);

  @override
  State<ManufacturingOrderPage> createState() => _ManufacturingOrderPageState();
}

class _ManufacturingOrderPageState extends State<ManufacturingOrderPage> {
  late bool _theme;
  late ManufacturingOrder manufacturingOrder;
  @override
  void initState() {
    super.initState();

    _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("manufacturing.title")),
      ),
      body: BlocConsumer<ManufacturingOrderBloc, ManufacturingOrderState>(
          listener: (context, state) {
        if (state is DeleteManufacturingOrderSuccess) {
          BlocProvider.of<ManufacturingOrderBloc>(context)
              .add(GetManufactoringOrderEvent());

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(translate('manufacturing.deletesuccess'))));
        }
        if (state is DeleteManufacturingOrderError) {
          BlocProvider.of<ManufacturingOrderBloc>(context)
              .add(GetManufactoringOrderEvent());

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(translate('manufacturing.deletefailed'))));
        }
      }, builder: (context, state) {
        if (state is ManufacturingOrderLoaded) {
          return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              scrollDirection: Axis.vertical,
              itemCount: state.manufacturingOrders.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text('delete confirmation'),
                            content: Text('sure you wanna delete the item'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    BlocProvider.of<ManufacturingOrderBloc>(
                                            context)
                                        .add(DeleteManufacturingOrderEvent(
                                            manufacturingOrderID: state
                                                .manufacturingOrders[index]
                                                .id!));
                                    return Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete')),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('Cancel')),
                            ],
                          );
                        });
                  },
                  key: ValueKey(state.manufacturingOrders[index]),
                  onDismissed: (direction) =>
                      BlocProvider.of<ManufacturingOrderBloc>(context).add(
                          DeleteManufacturingOrderEvent(
                              manufacturingOrderID:
                                  state.manufacturingOrders[index].id!)),
                  child: ManufactoringOrderWidget(
                    manufacturingOrder: state.manufacturingOrders[index],
                  ),
                );
              }
              // itemBuilder: (context, index) {
              //   final manufacturingOrder = state.manufacturingOrders[index];
              //   return ManufactoringOrderWidget(
              //     manufacturingOrder: manufacturingOrder,
              //   );
              // },
              );
        } else if (state is ManufacturingOrderLoadedError) {
          return Text(state.error);
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ));
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const
                  // UpdateManufacturingOrderLinePage(),
              AddManufactoringOrderPage(),
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
