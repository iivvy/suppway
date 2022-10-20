import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:suppwayy_mobile/deliveries/bloc/deliveries_bloc.dart';
import 'package:suppwayy_mobile/deliveries/model/deliveries_list_model.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_list_model.dart';

class AddSaleDelivery extends StatefulWidget {
  const AddSaleDelivery({Key? key}) : super(key: key);

  @override
  State<AddSaleDelivery> createState() => _AddSaleDeliveryState();
}

class _AddSaleDeliveryState extends State<AddSaleDelivery> {
  DateTime dateTime = DateTime.now();

  List<String> stateList = ["NOT_READY", "READY", "IN_PROGRESS", "DELIVERED"];
  late String states;
  List<String> signatureMethodeList = ["TEXT_MESSAGE", "EMAIL", "HANDWRITTEN"];
  late String signatureMethode;
  int saleOrderId = 0;
  late bool isSigned;
  @override
  void initState() {
    BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
    states = stateList.first;
    signatureMethode = signatureMethodeList.first;
    isSigned = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(translate("deliveries.addDelivery")),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.check,
                size: 30,
              ),
              onPressed: () {
                BlocProvider.of<DeliveriesBloc>(context).add(AddDelivery(
                    saleId: saleOrderId,
                    delivery: Delivery(
                        date: dateTime,
                        state: states,
                        signed: isSigned,
                        signatureMethod: signatureMethode)));
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(translate("deliveries.sale"),
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      BlocBuilder<SaleOrderBloc, SaleOrderState>(
                          builder: (context, state) {
                        if (state is SalesOrderLoaded) {
                          SaleOrder saleOrder = state.salesOrder.singleWhere(
                              (c) => c.id == saleOrderId,
                              orElse: () => state.salesOrder.first);
                          return DropdownButtonFormField(
                            icon: const Icon(
                              Icons.arrow_drop_down,
                            ),
                            isExpanded: true,
                            onChanged: (int? newVal) {
                              SaleOrder choosenSaleOrder = state.salesOrder
                                  .singleWhere((c) => c.id == newVal);
                              setState(() {
                                saleOrder = choosenSaleOrder;
                                saleOrderId = saleOrder.id;
                              });
                            },
                            value: saleOrder.id,
                            items: state.salesOrder.map((SaleOrder sale) {
                              return DropdownMenuItem<int>(
                                value: sale.id,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    sale.name.toString(),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        } else {
                          return Text(
                            translate("deliveries.salesNotFound"),
                          );
                        }
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(translate("deliveries.states"),
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      DropdownButtonFormField(
                        icon: const Icon(
                          Icons.arrow_drop_down,
                        ),
                        isExpanded: true,
                        onChanged: (String? newVal) {
                          setState(() {
                            states = newVal!;
                          });
                        },
                        value: states,
                        items: stateList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                value.toString(),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: width * 0.5,
                        padding: const EdgeInsets.only(top: 13.0),
                        child: Text(translate("sale.date"),
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      Container(
                        width: width * 0.9,
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          border: Border.all(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5)),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: InkWell(
                          onTap: () async {
                            DateTime date = await pickDate();

                            TimeOfDay time = await pickTime();

                            setState(() {
                              dateTime = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                time.hour,
                                time.minute,
                              );
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    DateFormat("yyyy-MM-dd  kk:mm").format(
                                      DateTime.parse(dateTime.toString()),
                                    ),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                const Icon(
                                  Icons.date_range,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(translate("deliveries.signatureMethode"),
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      DropdownButtonFormField(
                        icon: const Icon(
                          Icons.arrow_drop_down,
                        ),
                        isExpanded: true,
                        onChanged: (String? newVal) {
                          setState(() {
                            signatureMethode = newVal!;
                          });
                        },
                        value: signatureMethode,
                        items: signatureMethodeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(value.toString(),
                                  style: Theme.of(context).textTheme.subtitle1),
                            ),
                          );
                        }).toList(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5)),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: SwitchListTile(
                          title: Text(translate('deliveries.signed')),
                          value: isSigned,
                          activeColor: Colors.green,
                          onChanged: (bool value) {
                            setState(() {
                              isSigned = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime> pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 180)),
    );
    if (pickedDate != null) {
      return pickedDate;
    } else {
      return DateTime.now();
    }
  }

  Future<TimeOfDay> pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      return pickedTime;
    } else {
      return TimeOfDay.now();
    }
  }
}
