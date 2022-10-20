import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';
import 'package:suppwayy_mobile/lot/bloc/lot_bloc.dart';
import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';

class ProductLotUpdatePage extends StatefulWidget {
  const ProductLotUpdatePage(
      {Key? key, required this.lot, required this.product})
      : super(key: key);
  final Lot lot;
  final Product product;
  @override
  State<ProductLotUpdatePage> createState() => _ProductLotUpdatePageState();
}

class _ProductLotUpdatePageState extends State<ProductLotUpdatePage> {
  TextEditingController referenceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  DateTime dateTime = DateTime.now();
  late Location currentlocation;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    currentlocation = widget.lot.location;
    referenceController.text = widget.lot.reference;
    quantityController.text = widget.lot.quantity.toString();
    dateTime = widget.lot.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(translate("lot.updateLot")),
        actions: [
          PopupMenuButton(
            onSelected: (value){
              if (value ==0 ){

              }
            },
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<int>(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.print,
                        size: 20,
                        color: Colors.black,
                      ),
                      Text('print'),
                    ],
                  )),
                ];
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.send,
                  controller: referenceController,
                  decoration:
                      InputDecoration(label: Text(translate("lot.reference"))),
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<LotBloc>(context).add(PatchLotEvent(
                          lotID: widget.lot.id,
                          productID: widget.product.id!,
                          updateData: {
                            "reference": referenceController.text,
                          }));
                      Navigator.pop(context);
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.send,
                  controller: quantityController,
                  decoration:
                      InputDecoration(labelText: translate("lot.quantity")),
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<LotBloc>(context).add(PatchLotEvent(
                          lotID: widget.lot.id,
                          productID: widget.product.id!,
                          updateData: {
                            "quantity": quantityController.text,
                          }));
                      Navigator.pop(context);
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: currentlocation.ledgerName,
                  decoration:
                      InputDecoration(label: Text(translate("lot.location"))),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    border: Border.all(color: Theme.of(context).primaryColor),
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
                        var data = {
                          "date": DateFormat("yyyy-MM-dd H:mm")
                              .format(DateTime.parse(dateTime.toString())),
                        };

                        BlocProvider.of<LotBloc>(context).add(PatchLotEvent(
                            lotID: widget.lot.id,
                            productID: widget.product.id!,
                            updateData: data));
                        Navigator.pop(context);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              DateFormat("yyyy-MM-dd  kk:mm").format(
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
