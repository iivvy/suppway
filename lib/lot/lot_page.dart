import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/lot/bloc/lot_bloc.dart';
import 'package:suppwayy_mobile/lot/widgets/lot_card_widget.dart';
import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';

class LotPage extends StatefulWidget {
  const LotPage({Key? key}) : super(key: key);

  @override
  _LotPageState createState() => _LotPageState();
}

class _LotPageState extends State<LotPage> {
  bool isSearching = false;

  List<Lot> _filteredlots = [];
  final myController = TextEditingController();

  String value = "";

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    myController.addListener(_latestValue);
    super.initState();
  }

  void _latestValue() {
    setState(() {
      value = myController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text(translate("lot.lots"))
            : TextField(
                onChanged: (value) {
                  _latestValue();
                },
                controller: myController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: translate("lot.searchlot"),
                    hintStyle: const TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      myController.text = "";
                      isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: BlocBuilder<LotBloc, LotState>(
        builder: (context, state) {
          if (state is LotsInitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LotsLoaded) {
            _filteredlots = state.lots;
            if (isSearching == true) {
              _filteredlots = state.lots
                  .where((lot) =>
                      lot.reference.toLowerCase().contains(value.toLowerCase()))
                  .toList();

              return _filteredlots.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(color: Colors.black),
                      itemCount: _filteredlots.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: LotCardWidget(lot: _filteredlots[index])),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.black),
                itemCount: state.lots.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: LotCardWidget(lot: state.lots[index])),
                ),
              );
            }
          }
          return Center(
            child: Text(translate("lot.error")),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          BlocProvider.of<LotBloc>(context).add(GetLotsEvent());
        },
      ),
    );
  }
}
