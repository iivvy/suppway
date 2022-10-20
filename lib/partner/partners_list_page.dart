import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/partner/add_partner_page.dart';
import 'package:suppwayy_mobile/partner/bloc/partner_bloc.dart';
import 'package:suppwayy_mobile/partner/widgets/partner_card_widget.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';
import 'package:suppwayy_mobile/setting/bloc/setting_bloc.dart';
import 'package:suppwayy_mobile/setting/linear_gradient.dart';

class PartnersListPage extends StatefulWidget {
  const PartnersListPage({Key? key}) : super(key: key);

  @override
  _PartnersListPageState createState() => _PartnersListPageState();
}

class _PartnersListPageState extends State<PartnersListPage> {
  bool isSearching = false;

  List<Partner> _filteredpartners = [];
  final myController = TextEditingController();

  String value = "";
  late bool _theme;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    myController.addListener(_latestValue);
    super.initState();
    _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';
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
            ? Text(translate("partner.partners"))
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
                    hintText: translate("partner.searchpartner"),
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
      body: BlocConsumer<PartnerBloc, PartnerState>(
        listener: (context, state) {
          if (state is PartnerCreated) {
            BlocProvider.of<PartnerBloc>(context).add(GetPartnersEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("partner.createsuccess")),
              ),
            );
          } else if (state is PartnerCreationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("partner.createfailed")),
              ),
            );
          }

          if (state is DeletePartnerSuccess) {
            BlocProvider.of<PartnerBloc>(context).add(GetPartnersEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("partner.deletesuccess")),
              ),
            );
          } else if (state is DeletePartnerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("partner.deletefailed")),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PartnersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PartnersLoaded) {
            _filteredpartners = state.partners;

            if (isSearching == true) {
              _filteredpartners = state.partners
                  .where((partner) =>
                      partner.name.toLowerCase().contains(value.toLowerCase()))
                  .toList();

              return _filteredpartners.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _filteredpartners.length,
                      itemBuilder: (context, index) => Dismissible(
                          key: ValueKey(_filteredpartners[index]),
                          confirmDismiss: (direction) => promptUser(
                              direction, _filteredpartners[index].id),
                          child: PartnerCardWidget(
                              partner: _filteredpartners[index])))
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            } else {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.partners.length,
                  itemBuilder: (context, index) => Dismissible(
                      key: ValueKey(state.partners[index]),
                      confirmDismiss: (direction) =>
                          promptUser(direction, state.partners[index].id),
                      child:
                          PartnerCardWidget(partner: state.partners[index])));
            }
          }
          return Center(
            child: Text(translate("partner.error")),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPartnerPage(),
            ),
          );
        },
        child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: colorGradient(_theme),
            ),
            child: const Icon(Icons.add)),
      ),
    );
  }

  Future<bool> promptUser(DismissDirection direction, int partnerId) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text(translate("partner.deleteAlert")),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Ok"),
                onPressed: () {
                  BlocProvider.of<PartnerBloc>(context)
                      .add(DeletePartner(partnerId: partnerId));
                  return Navigator.of(context).pop(true);
                },
              ),
              CupertinoDialogAction(
                child: Text(translate("cancel")),
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        ) ??
        false;
  }
}
