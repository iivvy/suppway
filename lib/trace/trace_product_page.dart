import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/trace/bloc/trace_bloc.dart';
import 'package:suppwayy_mobile/trace/containers/bar_code_page.dart';
import 'package:suppwayy_mobile/trace/containers/qr_code_page.dart';
import 'package:suppwayy_mobile/trace/traceability_result_page.dart';

class TraceProductPage extends StatefulWidget {
  const TraceProductPage({Key? key}) : super(key: key);

  @override
  _TraceProductPageState createState() => _TraceProductPageState();
}

class _TraceProductPageState extends State<TraceProductPage> {
  bool scan = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TraceBloc, TraceState>(
      listener: (context, state) {
        if (state is TraceItemLoaded) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TraceProductResultPage(
                traceHistory: state.traceHistoryItem,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                BlocProvider.of<TraceBloc>(context).add(GetTraceHistory());
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              }),
          title: Text(translate('trace.trace')),
          actions: [
            IconButton(
                onPressed: () => setState(() => scan = !scan),
                icon: scan
                    ? const Icon(IconData(0xf00cc, fontFamily: 'MaterialIcons'))
                    : const ImageIcon(
                        AssetImage("assets/images/scanbarcode.png")))
          ],
        ),
        body: SafeArea(
          child: Center(
            child: scan ? const BarCodePage() : const QrCodePage(),
          ),
        ),
      ),
    );
  }
}
