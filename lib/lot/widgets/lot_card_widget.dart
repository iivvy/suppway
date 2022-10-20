import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/lot_list_model.dart';

class LotCardWidget extends StatefulWidget {
  const LotCardWidget({Key? key, required this.lot}) : super(key: key);
  final Lot lot;
  @override
  _LotCardWidgetState createState() => _LotCardWidgetState();
}

class _LotCardWidgetState extends State<LotCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.asset(
                "assets/images/lot.png",
                height: 40,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      widget.lot.reference,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                        DateFormat("dd / MM / yyyy")
                            .format(DateTime.parse(widget.lot.date.toString())),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.0)),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.lot.quantity.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}
