import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suppwayy_mobile/setting/bloc/setting_bloc.dart';
import 'package:suppwayy_mobile/trace/models/trace_list_model.dart';

class TraceStepWidget extends StatelessWidget {
  const TraceStepWidget(
      {Key? key,
      required this.index,
      required this.isNotLast,
      required this.step})
      : super(key: key);
  final int index;
  final bool isNotLast;
  final Trace step;

  @override
  Widget build(BuildContext context) {
// TODO check usefulenness
    bool _isDarkTheme = BlocProvider.of<SettingBloc>(context).theme == 'dark';
    return Stack(
      children: [
        isNotLast
            ? Container(
                margin: const EdgeInsets.only(
                  top: 5,
                  left: 17,
                ),
                width: 3,
                height: 70,
                color: _isDarkTheme
                    ? Colors.indigo.shade100
                    : Theme.of(context).primaryColor,
              )
            : Container(),
        Row(
          children: [
            Container(
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: _isDarkTheme ? Colors.black87 : Colors.white,
                  ),
                ),
              ),
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: _isDarkTheme
                      ? Colors.indigo.shade100
                      : Theme.of(context).primaryColor,
                  shape: BoxShape.circle),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.locationID,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  step.lastTransferDate,
                  style: Theme.of(context).textTheme.headline4,
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
