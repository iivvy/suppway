import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:suppwayy_mobile/deliveries/bloc/deliveries_bloc.dart';
import 'package:suppwayy_mobile/deliveries/model/deliveries_line_model.dart';
import 'package:suppwayy_mobile/deliveries/model/deliveries_list_model.dart';
import 'package:suppwayy_mobile/deliveries/widget/sale_delivery_line_card_widget.dart';

class SaleDeliveryDetailsPage extends StatefulWidget {
  const SaleDeliveryDetailsPage({Key? key, required this.delivery})
      : super(key: key);
  final Delivery delivery;
  @override
  State<SaleDeliveryDetailsPage> createState() =>
      _SaleDeliveryDetailsPageState();
}

class _SaleDeliveryDetailsPageState extends State<SaleDeliveryDetailsPage> {
  late List<DeliveryLines> _deliveryLines;
  List<String> stateList = ["NOT_READY", "READY", "IN_PROGRESS", "DELIVERED"];
  late String states;
  int index = 0;
  late String getGTIN = "0";
  @override
  void initState() {
    _deliveryLines = widget.delivery.saleDeliveryLines!.deliveriesLines;
    states = widget.delivery.state;
    index = stateList.indexOf(states);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocListener<DeliveriesBloc, DeliveriesState>(
      listener: (context, state) {
        if (state is DeliveryLineUpdated) {
          BlocProvider.of<DeliveriesBloc>(context).add(GetDeliveriesEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate("deliveries.updateLinesuccess")),
            ),
          );
        }
        if (state is DeliveryLineUpdatedFailed) {
          BlocProvider.of<DeliveriesBloc>(context).add(GetDeliveriesEvent());

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate("deliveries.updateLinefailed")),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(translate("deliveries.deliveryDetail")),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: SizedBox(
                  width: width,
                  height: height * 0.34,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.9,
                        height: height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat.yMd().format(widget.delivery.date),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            IconButton(
                                onPressed: () {
                                  scanQrCode().then((value) {
                                    setState(() {
                                      getGTIN = value;
                                    });
                                  });
                                },
                                icon: const ImageIcon(
                                  AssetImage("assets/images/scanbarcode.png"),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: buildLabels(labels: stateList, value: index),
                      ),
                      SizedBox(
                        height: height * 0.13,
                        child: Stepper(
                            elevation: 0,
                            // controlsBuilder: (context,
                            //     {onStepCancel, onStepContinue}) {
                            //   return Row(
                            //     children: <Widget>[
                            //       TextButton(
                            //           onPressed: onStepContinue,
                            //           child: Text('')),
                            //       TextButton(
                            //           onPressed: onStepCancel, child: Text('')),
                            //     ],
                            //   );
                            // },
                            type: StepperType.horizontal,
                            currentStep: index,
                            onStepTapped: (int value) {
                              setState(() {
                                index = value;
                                BlocProvider.of<DeliveriesBloc>(context).add(
                                    PatchDeliveryEvent(
                                        deliveryId: widget.delivery.id!,
                                        updateData: {
                                      "state": stateList[index],
                                    }));
                              });
                            },
                            steps: <Step>[
                              Step(
                                  isActive: index >= 0,
                                  content: Text(""),
                                  title: Text("")),
                              Step(
                                  isActive: index >= 1,
                                  content: Text(""),
                                  title: Text("")),
                              Step(
                                  isActive: index >= 2,
                                  content: Text(""),
                                  title: Text("")),
                              Step(
                                  isActive: index == 3,
                                  content: Text(""),
                                  title: Text("")),
                            ]),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.delivery.signatureMethod,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          widget.delivery.signed
                              ? Image.asset(
                                  "assets/images/signed.png",
                                  color: Colors.green,
                                  height: 25,
                                  width: 50,
                                )
                              : Text(""),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: height * 0.59,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    scrollDirection: Axis.vertical,
                    itemCount: _deliveryLines.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SaleDeliveryLineCardWidget(
                          checkGTIN: getGTIN,
                          deliveryId: widget.delivery.id!,
                          deliveryLines: _deliveryLines[index]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> scanQrCode() async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#000000', 'Cancel', true, ScanMode.BARCODE);
    return qrCode;
  }

  Widget buildLabels({
    required List<String> labels,
    required int value,
  }) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: modelBuilder(
            labels,
            (index, label) {
              final selectedColor = Colors.black;
              final unselectedColor = Colors.black.withOpacity(0.3);
              final isSelected = index <= value;
              final color = isSelected ? selectedColor : unselectedColor;
              return buildLabel(label: label, color: color, width: 78);
            },
          ),
        ),
      );
  Widget buildLabel({
    //label
    required Object? label,
    required double width,
    required Color color,
  }) =>
      SizedBox(
        width: width,
        child: Text(
          translate("deliveries.$label"),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ).copyWith(color: color),
        ),
      );
  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}
