import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:suppwayy_mobile/location/bloc/location_bloc.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';
import 'package:suppwayy_mobile/lot/bloc/lot_bloc.dart';
import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';

class ProductLotAddPage extends StatefulWidget {
  const ProductLotAddPage({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  State<ProductLotAddPage> createState() => _ProductLotAddPageState();
}

class _ProductLotAddPageState extends State<ProductLotAddPage> {
  TextEditingController referenceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  DateTime dateTime = DateTime.now();
  late Location currentlocation;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("lot.Addlot")),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              size: 30,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<LotBloc>(context).add(AddLotEvent(
                    lotData: Lot(
                        date: dateTime,
                        location: currentlocation,
                        quantity: int.parse(quantityController.text),
                        id: 0,
                        reference: referenceController.text),
                    productID: widget.product.id!));
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    referenceController.text = value;
                  },
                  decoration:
                      InputDecoration(label: Text(translate("lot.reference"))),
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
                  onChanged: (value) {
                    quantityController.text = value;
                  },
                  decoration:
                      InputDecoration(label: Text(translate("lot.quantity"))),
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
                SizedBox(
                  width: width,
                  child: BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, state) {
                    //Todo validate location
                    if (state is LocationsLoaded) {
                      return DropdownButtonFormField<Location>(
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                        ),
                        onChanged: (value) {
                          setState(() {
                            currentlocation = value!;
                          });
                        },
                        items: state.locationsListModel.locations
                            .map<DropdownMenuItem<Location>>(
                                (Location location) {
                          return DropdownMenuItem<Location>(
                            value: location,
                            child: Text(
                              location.ledgerName!,
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return Container();
                  }),
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
