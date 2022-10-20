import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:suppwayy_mobile/manufacturing/add_manufacturing_order_line.dart';
import 'package:suppwayy_mobile/manufacturing/bloc/manufacturing_order_bloc.dart';
import 'package:suppwayy_mobile/manufacturing/models/manufacturing_order_list_model.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:suppwayy_mobile/manufacturing/widgets/manufacturing_order_line_card_widget.dart';

class ManufacturingOrderDetailPage extends StatefulWidget {
  const ManufacturingOrderDetailPage(
      {Key? key, required this.manufacturingOrder})
      : super(key: key);
  final ManufacturingOrder manufacturingOrder;

  @override
  State<ManufacturingOrderDetailPage> createState() =>
      _ManufacturingOrderDetailPage();
}

class _ManufacturingOrderDetailPage
    extends State<ManufacturingOrderDetailPage> {
  late ManufacturingOrder manufacturingOrder;
  DateTime dateTime = DateTime.now();
  TextEditingController manufacturingOrderNameEditingController =
      TextEditingController();
  List<String> states = ['CONFIRMED', 'CANCEL', 'DRAFT'];
  late String state;
  late SlidableButtonPosition position;
  late String manufacturingOrderStatus;
  @override
  @override
  void initState() {
    manufacturingOrder = widget.manufacturingOrder;
    manufacturingOrderNameEditingController =
        TextEditingController(text: manufacturingOrder.name);
    state = manufacturingOrder.status;
    dateTime = manufacturingOrder.date;
    manufacturingOrderStatus = manufacturingOrder.status;
    if (manufacturingOrderStatus == "CONFIRMED") {
      position = SlidableButtonPosition.end;
    } else {
      position = SlidableButtonPosition.start;
    }
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
      child: BlocListener<ManufacturingOrderBloc, ManufacturingOrderState>(
        listener: (context, state) {
          if (state is UpdateManufacturingOrderSuccess) {
            BlocProvider.of<ManufacturingOrderBloc>(context)
                .add(GetManufactoringOrderEvent());
            // Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(translate('manufacturing.updatesuccess'))));

            if (state is UpdateManufacturingOrderError) {
              BlocProvider.of<ManufacturingOrderBloc>(context)
                  .add(GetManufactoringOrderEvent());
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('manufacturing.updatefailed')));
            }
          }
          if (state is ManufacturingOrderLineAdded) {
            BlocProvider.of<ManufacturingOrderBloc>(context)
                .add(GetManufactoringOrderEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("line.createsuccess")),
              ),
            );
          } else if (state is AddManufacturingOrderLineFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("line.createfailed")),
              ),
            );
          }
        },
        child: Scaffold(
            resizeToAvoidBottomInset : false,
            appBar: AppBar(
              title: TextField(
                controller: manufacturingOrderNameEditingController,
                style: Theme.of(context).appBarTheme.titleTextStyle,
                onSubmitted: (value) {
                  BlocProvider.of<ManufacturingOrderBloc>(context).add(
                      UpdateManufacturingOrderEvent(
                          manufacturingOrderID: widget.manufacturingOrder.id!,
                          updateManufacturingOrderData: {"name": value}));
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
              actions: [
                PopupMenuButton(
                  icon: Icon(
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
                              Icons.cancel,
                              color: Theme.of(context).iconTheme.color,
                              size: 17,
                            ),
                            Text('Cancel')
                          ],
                        ),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    manufacturingOrderStatus = "Cancel";
                    BlocProvider.of<ManufacturingOrderBloc>(context).add(
                        UpdateManufacturingOrderEvent(
                            manufacturingOrderID: widget.manufacturingOrder.id!,
                            updateManufacturingOrderData: {
                          "state": manufacturingOrderStatus.toUpperCase()
                        }));
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: width - 100,
                          height: 40,
                          child: HorizontalSlidableButton(
                            onChanged: (position) {
                              setState(() {
                                if (position == SlidableButtonPosition.end) {
                                  manufacturingOrderStatus = "CONFIRMED";
                                  BlocProvider.of<ManufacturingOrderBloc>(
                                          context)
                                      .add(UpdateManufacturingOrderEvent(
                                          manufacturingOrderID:
                                              widget.manufacturingOrder.id!,
                                          updateManufacturingOrderData: {
                                        "state": manufacturingOrderStatus
                                            .toUpperCase()
                                      }));
                                } else if (position ==
                                    SlidableButtonPosition.start) {
                                  manufacturingOrderStatus = 'DRAFT';
                                  BlocProvider.of<ManufacturingOrderBloc>(
                                          context)
                                      .add(UpdateManufacturingOrderEvent(
                                          manufacturingOrderID:
                                              widget.manufacturingOrder.id!,
                                          updateManufacturingOrderData: {
                                        "state": manufacturingOrderStatus
                                            .toUpperCase()
                                      }));
                                }
                              });
                            },
                            initialPosition: position,
                            width: width / 1.15,
                            buttonWidth: 100.0,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.4),
                            buttonColor: Theme.of(context).primaryColor,
                            dismissible: false,
                            label: Center(
                                child: Text(
                              manufacturingOrderStatus,
                              style: Theme.of(context).textTheme.headline5,
                            )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Draft",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Text(
                                    "Confirmed",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          // height: height * 0.05,
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  width: width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor),
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
                                              .format(DateTime.parse(
                                                  dateTime.toString())),
                                        };

                                        BlocProvider.of<ManufacturingOrderBloc>(
                                                context)
                                            .add(UpdateManufacturingOrderEvent(
                                                manufacturingOrderID: widget
                                                    .manufacturingOrder.id!,
                                                updateManufacturingOrderData:
                                                    data));
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Text(
                                            DateFormat("yyyy-MM-dd  H:mm")
                                                .format(
                                              DateTime.parse(
                                                  dateTime.toString()),
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.date_range,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(height: 15),
                                // Container(
                                //   width: width * 0.94,
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 20.0),
                                //   child: DropdownButtonFormField(
                                //     decoration: InputDecoration(
                                //         label: Text(
                                //             translate('manufacturing.state'))),
                                //     isExpanded: true,
                                //     focusColor: Theme.of(context).primaryColor,
                                //     icon: Icon(
                                //       Icons.arrow_drop_down,
                                //       color: Theme.of(context).primaryColor,
                                //     ),
                                //     onChanged: (String? newVal) {
                                //       setState(() {
                                //         state = newVal!;
                                //       });
                                //       BlocProvider.of<ManufacturingOrderBloc>(
                                //               context)
                                //           .add(UpdateManufacturingOrderEvent(
                                //               manufacturingOrderID:
                                //                   widget.manufacturingOrder.id!,
                                //               updateManufacturingOrderData: {
                                //             "state": state
                                //           }));
                                //     },
                                //     value: state,
                                //     items: states.map((String value) {
                                //       return DropdownMenuItem<String>(
                                //         value: value,
                                //         child: Padding(
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 20.0),
                                //           child: Text(
                                //             value.toString(),
                                //           ),
                                //         ),
                                //       );
                                //     }).toList(),
                                //   ),
                                // ),
                                SizedBox(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            translate("manufacturing.lines"),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.only(top: 10),
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddManufacturingOrderLine(
                                                            manufacturingOrder:
                                                                manufacturingOrder),
                                                  ));
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              size: 22,
                                            ),
                                            hoverColor: Colors.grey,
                                          ),
                                        ],
                                      )),
                                ),

                                SizedBox(
                                  height: height*0.6,

                                  child:ListView.builder(

                                      padding: const EdgeInsets.all(10.0),
                                      scrollDirection: Axis.vertical,

                                      itemCount: widget.manufacturingOrder.lines!.manufacturingOrderLines!.length,
                                      itemBuilder: (context,int index)=>Center(

                                        child: ManufacturingOrderLineCard(
                                            manufacturingOrder: widget.manufacturingOrder, manufacturingOrderLine: widget.manufacturingOrder.lines!.manufacturingOrderLines[index]
                                        ),
                                      ))

                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            )),
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
