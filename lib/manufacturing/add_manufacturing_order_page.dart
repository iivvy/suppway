import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:suppwayy_mobile/manufacturing/add_manufacturing_order_line.dart';
import 'package:suppwayy_mobile/manufacturing/bloc/manufacturing_order_bloc.dart';
import 'package:suppwayy_mobile/manufacturing/models/line_data.dart';
import 'package:suppwayy_mobile/manufacturing/models/manufacturing_order_list_model.dart';

import 'package:suppwayy_mobile/setting/bloc/setting_bloc.dart';

class AddManufactoringOrderPage extends StatefulWidget {
  const AddManufactoringOrderPage({Key? key}) : super(key: key);

  @override
  State<AddManufactoringOrderPage> createState() =>
      _AddManufactoringOrderPageState();
}

class _AddManufactoringOrderPageState extends State<AddManufactoringOrderPage> {
  late ManufacturingOrder manufacturingOrder;

  DateTime dateTime = DateTime.now();
  List<ManufacturingLineData> lines = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  List<String> states = ["draft", "confirmed", "cancel"];
  late String state;
  // ignore: unused_field
  late bool _theme;
  @override
  void initState() {
    _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';
    super.initState();
    state = states.first;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: BlocListener<ManufacturingOrderBloc, ManufacturingOrderState>(
          listener: (context, state) {
            if (state is ManufacturingOrderCreated) {
              BlocProvider.of<ManufacturingOrderBloc>(context)
                  .add(GetManufactoringOrderEvent());
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(translate('manufacturing.createsuccess'))),
              );
              // Navigator.pop(context);
              if (state is ManufacturingOrderCreationFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(translate('manufacturing.createfailed'))),
                );
                Navigator.pop(context);
              }
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(translate("manufacturing.neworder")),
              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.check,
                      size: 30,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<ManufacturingOrderBloc>(context).add(
                          AddManufacturingOrderEvent(
                            date: dateTime,
                            status: state,
                            name: nameController.text,
                            lines: lines,
                          ),
                        );

                      }
                    })
              ],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            label: Text(translate(
                                'manufacturing.name'))), //add the name to transaltor
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translate('manufacturing.emptyfield');
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(translate('manufacturing.state'),
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            DropdownButtonFormField(
                              icon: const Icon(
                                Icons.arrow_drop_down,
                              ),
                              isExpanded: true,
                              onChanged: (String? newVal) {
                                setState(() {
                                  state = newVal!;
                                });
                              },
                              value: state,
                              items: states.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
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
                              // width: width * 0.5,
                              padding: const EdgeInsets.only(top: 13.0),
                              child: Text(translate("manufacturing.date"),
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            Container(
                              // width: width * 0.9,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text(
                                          DateFormat("yyyy-MM-dd kk:mm").format(
                                            DateTime.parse(dateTime.toString()),
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
                            ),
                            // SizedBox(
                            //   height: height / 2.5,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddManufacturingOrderLine(),
                  ),
                );
                if (result is ManufacturingLineData) {
                  setState(() {
                    lines.add(result);
                  });
                }
              },
              child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add)),
            ),
          ),
        ));
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
