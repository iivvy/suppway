import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

import 'package:suppwayy_mobile/location/models/location_list_model.dart';
import 'package:suppwayy_mobile/sale/models/line_data.dart';
import 'package:suppwayy_mobile/setting/bloc/setting_bloc.dart';
import 'package:suppwayy_mobile/setting/linear_gradient.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';
import 'package:suppwayy_mobile/sale/containers/new_lines_list.dart';
import 'package:suppwayy_mobile/sale/add_sale_order_line.dart';

import 'widgets/add_partner_card_widget.dart';

class AddSaleOrderPage extends StatefulWidget {
  const AddSaleOrderPage({Key? key}) : super(key: key);

  @override
  State<AddSaleOrderPage> createState() => _AddSaleOrderPageState();
}

class _AddSaleOrderPageState extends State<AddSaleOrderPage> {
  DateTime dateTime = DateTime.now();
  var formKey = GlobalKey<FormState>();

  String name = "";
  List<LineData> lines = [];
  TextEditingController commentEditingController = TextEditingController();
  static LocationListModel location = const LocationListModel();
  List<Location> locationListPartner = [];
  int deliverylocation = 0;

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
  late bool _theme;

  @override
  void initState() {
    _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';
    locationListPartner = selectedPartner.locations!.locations;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocListener<SaleOrderBloc, SaleOrderState>(
          listener: (context, state) {
            if (state is SaleOrderCreated) {
              BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translate("sale.createsuccess")),
                ),
              );
              Navigator.pop(context);
              if (state is SalesOrderLoadingError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(translate("sale.createfailed")),
                  ),
                );
                Navigator.pop(context);
              }
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(translate("sale.title")),
              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.check,
                      size: 30,
                    ),
                    onPressed: () {
                      if (selectedPartner.id == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(translate("partner.searchpartner")),
                          ),
                        );
                      } else {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SaleOrderBloc>(context).add(
                              AddSaleOrderEvent(
                                  lines: lines,
                                  name: name,
                                  comment: commentEditingController.text,
                                  partner: selectedPartner,
                                  date: dateTime,
                                  deliverylocation: deliverylocation));
                        }
                      }
                    }),
              ],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      AddPartnerCardWidget(
                        setSelectedPartner: (partner) {
                          selectedPartner = partner;
                          locationListPartner =
                              selectedPartner.locations!.locations;
                          if (locationListPartner.isNotEmpty) {
                            deliverylocation = locationListPartner.first.id!;
                          } else {
                            deliverylocation = 0;
                          }
                        },
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0)),
                      Container(
                        width: width * 0.9,
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50.0),
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
                      (deliverylocation != 0)
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                focusColor: Theme.of(context).primaryColor,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    deliverylocation = newValue!;
                                  });
                                },
                                value: deliverylocation,
                                items: locationListPartner
                                    .map<DropdownMenuItem<int>>(
                                        (Location location) {
                                  return DropdownMenuItem<int>(
                                    key: UniqueKey(),
                                    value: location.id,
                                    child: Text(location.ledgerName!),
                                  );
                                }).toList(),
                              ),
                            )
                          : Container(),
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 8.0, left: 8.0, right: 8.0, top: 20.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.shade100,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(0.0),
                            )),
                        child: TextFormField(
                          controller: commentEditingController,
                          // keyboardType: TextInputType.multiline,
                          onFieldSubmitted: (value) {},
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: translate("sale.comment")),
                        ),
                      ),
                      SizedBox(
                        height: height / 2.5,
                        child: NewLinesListContainer(lines: lines),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddSaleOrderLine(),
                  ),
                );
                if (result is LineData) {
                  setState(() {
                    lines.add(result);
                  });
                }
              },
              child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, gradient: colorGradient(_theme)),
                  child: const Icon(Icons.add)),
            ),
          )),
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
