import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';
import 'package:suppwayy_mobile/sale/widgets/update_partner_card_widget.dart';

import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_line_list_model.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_list_model.dart';

import 'containers/sale_order_comment_tab.dart';
import 'containers/sale_order_info_tab.dart';
import 'containers/sale_order_line_tab.dart';
import 'containers/sale_order_optional_line_tab.dart';

class SaleOrderDetailPage extends StatefulWidget {
  const SaleOrderDetailPage({Key? key, required this.saleOrder})
      : super(key: key);
  final SaleOrder saleOrder;

  @override
  State<SaleOrderDetailPage> createState() => _SaleOrderDetailPageState();
}

class _SaleOrderDetailPageState extends State<SaleOrderDetailPage> {
  static LocationListModel location = const LocationListModel();
  int deliverylocation = 0;
  List<Location> locationListPartner = [];

  Partner buyer = Partner(
      id: 0,
      name: "",
      phone: "",
      address: "",
      email: "",
      website: "",
      locations: location,
      photo: '',
      stripeId: '',
      status: '');

  late SaleOrder saleOrder;
  List<SaleOrderLine> lines = [];
  DateTime dateTime = DateTime.now();
  late int status;
  late String saleOrderStatus;

  TextEditingController saleOrderNameEditingController =
      TextEditingController();
  TextEditingController commentEditingController = TextEditingController();
  late bool active;
  double translateX = 0.0;
  double translateY = 0.0;
  late double myWidth;
  int canLoop = -1;
  late bool statusCodeCancel;
  late SlidableButtonPosition position;
  @override
  void initState() {
    active = false;
    statusCodeCancel = false;
    saleOrder = widget.saleOrder;
    saleOrderStatus = saleOrder.status.toLowerCase();
    if (saleOrderStatus == "confirmed") {
      position = SlidableButtonPosition.end;
    } else {
      position = SlidableButtonPosition.start;
    }
    locationListPartner = saleOrder.buyer.locations!.locations;
    deliverylocation = saleOrder.deliveryLocation.id!;
    lines = saleOrder.lines.saleOrderLines;
    dateTime = saleOrder.date;
    saleOrderNameEditingController =
        TextEditingController(text: saleOrder.name);
    commentEditingController = TextEditingController(text: saleOrder.comment);

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
          if (state is SaleOrderDeleted) {
            BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("sale.deletesuccess")),
              ),
            );
            Navigator.pop(context);
          } else if (state is DeleteSaleOrderFailed) {
            BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("sale.deletefailed")),
              ),
            );
          } else if (state is SalesOrderLoaded) {
            setState(
              () {
                saleOrder = state.salesOrder
                    .firstWhere((a) => a.id == widget.saleOrder.id);
                lines = saleOrder.lines.saleOrderLines.isNotEmpty
                    ? saleOrder.lines.saleOrderLines
                    : [];
              },
            );
          } else if (state is SaleOrderLineDeleted) {
            BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("line.deletesuccess")),
              ),
            );
          } else if (state is DeleteSaleOrderLineFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("line.deletefailed")),
              ),
            );
          } else if (state is SaleOrderLineAdded) {
            BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("line.createsuccess")),
              ),
            );
          } else if (state is AddSaleOrderLineFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("line.createfailed")),
              ),
            );
          }
          if (state is SaleOrderOptionalLineCreated) {
            BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("line.createsuccess")),
              ),
            );
          } else if (state is SaleOrderOptionalLineCreateFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("line.createfailed")),
              ),
            );
          }

          if (state is SaleOrderOptionalLineDeleted) {
            BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("sale.deletesuccess")),
              ),
            );
          } else if (state is DeleteSaleOrderOptionalLineFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("sale.deletefailed")),
              ),
            );
          }
          if (state is SaleOrderUpdated) {
            BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("sale.updatesuccess")),
              ),
            );
          } else if (state is SaleOrderUpdateFailed) {
            BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("sale.updatefailed")),
              ),
            );
          }

          if (state is SaleOrderoptionalLineUpdated) {
            BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("sale.updatesuccess")),
              ),
            );
          } else if (state is UpdateSaleOrderOptionalLineFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("sale.updatefailed")),
              ),
            );
          }
          if (state is SendEmailSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("sale.sendsuccess")),
              ),
            );
          } else {
            if (state is SendEmailError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translate("sale.sendfailed")),
                ),
              );
            }
          }
          if (state is PrintSaleOrderSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("sale.printsuccess")),
              ),
            );
          } else {
            if (state is PrintSaleOrderError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translate("sale.printfailed")),
                ),
              );
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: saleOrderNameEditingController,
              style: Theme.of(context).appBarTheme.titleTextStyle,
              onSubmitted: (value) {
                BlocProvider.of<SaleOrderBloc>(context).add(PatchSaleOrderEvent(
                    saleOrderID: saleOrder.id, updateData: {"name": value}));
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: translate("sale.name")),
            ),
            actions: [
              PopupMenuButton(
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
                            Icon(
                              Icons.print,
                              color: Theme.of(context).iconTheme.color,
                              size: 17,
                            ),
                            Text(translate("sale.print")),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Transform.rotate(
                              angle: -2 * pi / 12,
                              child: Icon(
                                Icons.send,
                                color: Theme.of(context).iconTheme.color,
                                size: 17,
                              ),
                            ),
                            Text(translate("sale.send")),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.cancel,
                              color: Theme.of(context).iconTheme.color,
                              size: 17,
                            ),
                            Text(translate("Cancel")),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Theme.of(context).iconTheme.color,
                              size: 17,
                            ),
                            Text(translate("sale.delete")),
                          ],
                        ),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 0) {
                      BlocProvider.of<SaleOrderBloc>(context).add(
                          PrintSaleOrder(saleorderID: widget.saleOrder.id));
                    } else if (value == 1) {
                      BlocProvider.of<SaleOrderBloc>(context)
                          .add(SendSaleOrder(saleorderID: widget.saleOrder.id));
                    } else if (value == 2) {
                      saleOrderStatus = "cancel";
                      BlocProvider.of<SaleOrderBloc>(context).add(
                        PatchSaleOrderEvent(
                            saleOrderID: widget.saleOrder.id,
                            updateData: {
                              "status": saleOrderStatus.toUpperCase()
                            }),
                      );
                    } else if (value == 3) {
                      showDeleteAlert(context);
                    }
                  }),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.45,
                  child: Column(children: [
                    UpdatePartnerCardWidget(
                      saleOrder: saleOrder,
                      setSelectedPartner: (partner) {
                        buyer = partner;
                        locationListPartner = buyer.locations!.locations;
                        if (locationListPartner.isNotEmpty) {
                          deliverylocation = locationListPartner.first.id!;
                        } else {
                          deliverylocation = 0;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: width - 100,
                              height: 40,
                              child: HorizontalSlidableButton(
                                initialPosition: position,
                                width: width / 1.15,
                                buttonWidth: 100.0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.4),
                                buttonColor: Theme.of(context).primaryColor,
                                dismissible: false,
                                label: Center(
                                    child: Text(
                                  translate("product.slide"),
                                  style: Theme.of(context).textTheme.headline5,
                                )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        translate("sale.states.draft"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      Text(
                                        translate("sale.states.confirmed"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ],
                                  ),
                                ),
                                onChanged: (position) {
                                  setState(
                                    () {
                                      if (position ==
                                          SlidableButtonPosition.end) {
                                        saleOrderStatus = "confirmed";
                                        BlocProvider.of<SaleOrderBloc>(context)
                                            .add(PatchSaleOrderEvent(
                                                saleOrderID:
                                                    widget.saleOrder.id,
                                                updateData: {
                                              "status":
                                                  saleOrderStatus.toUpperCase()
                                            }));
                                      } else {
                                        // BlocProvider.of<ProductBloc>(context).add(
                                        //   PatchProduct(
                                        //     productId: widget.saleOrder.id,
                                        //     updatedProductData: const {
                                        //       'published': "false"
                                        //     },
                                        // ),
                                        // );
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
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
                            var data = {
                              "date": DateFormat("yyyy-MM-dd H:mm")
                                  .format(DateTime.parse(dateTime.toString())),
                            };

                            BlocProvider.of<SaleOrderBloc>(context).add(
                                PatchSaleOrderEvent(
                                    saleOrderID: saleOrder.id,
                                    updateData: data));
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                DateFormat("yyyy-MM-dd  H:mm").format(
                                  DateTime.parse(dateTime.toString()),
                                ),
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            const Icon(
                              Icons.date_range,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            label: Text(translate("sale.location"))),
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
                          BlocProvider.of<SaleOrderBloc>(context).add(
                              PatchSaleOrderEvent(
                                  saleOrderID: widget.saleOrder.id,
                                  updateData: {
                                "deliveryLocation_id": "$deliverylocation"
                              }));
                        },
                        value: deliverylocation,
                        items: locationListPartner
                            .map<DropdownMenuItem<int>>((Location location) {
                          return DropdownMenuItem<int>(
                            key: UniqueKey(),
                            value: location.id,
                            child: Text(location.ledgerName!),
                          );
                        }).toList(),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  // TODO cal the exact height
                  height: height * 0.6,
                  child: DefaultTabController(
                    length: 4,
                    child: Scaffold(
                      appBar: PreferredSize(
                          preferredSize: const Size.fromHeight(kToolbarHeight),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TabBar(
                              isScrollable: true,
                              indicatorColor: Colors.black26,
                              tabs: [
                                Text(
                                  translate("sale.Information"),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  translate("sale.line"),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  translate("sale.optionalLine"),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  translate("sale.comment"),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                          )),
                      body: TabBarView(
                        children: [
                          SaleOrderInfoTab(saleOrder: saleOrder),
                          SaleOrderLineTab(saleOrder: saleOrder),
                          SaleOrderOptionalLineTab(saleOrder: saleOrder),
                          SaleOrderCommentTab(saleOrder: saleOrder),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDeleteAlert(BuildContext context) async {
    await showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Text(translate("sale.deleteAlert")),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("Ok"),
            onPressed: () {
              BlocProvider.of<SaleOrderBloc>(context)
                  .add(DeleteSaleOrderEvent(saleOrderID: widget.saleOrder.id));
              return Navigator.of(context).pop();
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

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  Widget buildSheet() => makeDismissible(
        child: DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.1,
          maxChildSize: 0.85,
          builder: (_, controller) => Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            padding: const EdgeInsets.all(16),
            height: 300,
            child: ListView(
              controller: controller,
            ),
          ),
        ),
      );
}
