import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/commons/drawer_widget.dart';
import 'package:suppwayy_mobile/trace/bloc/trace_bloc.dart';
import 'package:suppwayy_mobile/trace/trace_product_page.dart';
import 'package:suppwayy_mobile/trace/widgets/trace_card_widget.dart';

class TracePage extends StatefulWidget {
  const TracePage({Key? key}) : super(key: key);

  @override
  _TracePageState createState() => _TracePageState();
}

class _TracePageState extends State<TracePage> {
  var index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("trace.trace")),
      ),
      drawer: const DrawerWidget(),
      body: BlocBuilder<TraceBloc, TraceState>(builder: (context, state) {
        if (state is TraceHistoryLoaded) {
          return ListView.builder(
              itemCount: state.tracehistory.length,
              itemBuilder: (context, index) {
                final trace = state.tracehistory[index];
                return Dismissible(
                  key: ValueKey(state.tracehistory[index]),
                  background: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onDismissed: (direction) =>
                      BlocProvider.of<TraceBloc>(context).add(
                          DeleteTraceHistory(index: state.tracehistory[index])),
                  child: TraceCardWidget(
                    trace: trace,
                    index: index + 1,
                  ),
                );
              });
        } else if (state is TraceHistoryLoadedError) {
          return Text(state.error);
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ));
        }
      }),
      floatingActionButton: SizedBox(
        height: 50,
        width: 100,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TraceProductPage(),
              ),
            );
          },
          child: Row(
            children: [
              Text(translate("trace.button.trace")),
              const ImageIcon(AssetImage("assets/images/tracehome.png")),
            ],
          ),
        ),
      ),
    );
  }
}
