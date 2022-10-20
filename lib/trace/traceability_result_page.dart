import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/trace/bloc/trace_bloc.dart';
import 'package:suppwayy_mobile/trace/models/trace_history_model.dart';
import 'package:suppwayy_mobile/trace/models/trace_list_model.dart';
import 'package:suppwayy_mobile/trace/models/trace_request_model.dart';
import 'package:suppwayy_mobile/trace/widgets/trace_step_widget.dart';

class TraceProductResultPage extends StatelessWidget {
  const TraceProductResultPage({Key? key, required this.traceHistory})
      : super(key: key);
  final TraceHistory traceHistory;

  @override
  Widget build(BuildContext context) {
    List<Trace> traces = traceHistory.traceList.traces;
    TraceProductRequest request = traceHistory.traceRequest;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              BlocProvider.of<TraceBloc>(context).add(GetTraceHistory());
              Navigator.popUntil(context, ModalRoute.withName('/'));
            }),
        title: Text(translate("trace.trace")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: 100.0,
                      minHeight: 50.0,
                      minWidth: MediaQuery.of(context).size.width),
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: request.traceableItemID == ""
                          ? Row(
                              children: [
                                Text(
                                  "${translate('product.lot')}: ${request.lotNumber} \n${translate('product.gtin')}: ${request.gs1GTIN}",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            )
                          : Text(
                              "${translate("product.traceableItemID")}: ${request.traceableItemID}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
              ),
              child: SingleChildScrollView(
                physics: const PageScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: traces.map((t) {
                      return TraceStepWidget(
                          index: traces.indexOf(t),
                          isNotLast: (traces.indexOf(t) < (traces.length - 1)),
                          step: t);
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
