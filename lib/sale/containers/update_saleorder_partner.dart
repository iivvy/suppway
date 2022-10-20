import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suppwayy_mobile/partner/bloc/partner_bloc.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';

class UpdateSaleOrderPartner extends StatefulWidget {
  const UpdateSaleOrderPartner({
    Key? key,
  }) : super(key: key);
  @override
  State<UpdateSaleOrderPartner> createState() => _UpdateSaleOrderPartnerState();
}

class _UpdateSaleOrderPartnerState extends State<UpdateSaleOrderPartner> {
  List<Partner> partners = [];
  List<String> partnersNames = [];
  late Partner selectedPartner;

  TextEditingController partnerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.1, left: 8.0, right: 8.0),
        child: Row(
          children: [
            Flexible(
              child: BlocBuilder<PartnerBloc, PartnerState>(
                  builder: (context, state) {
                if (state is PartnersLoaded) {
                  partners = state.partners;
                  state.partners.every((partner) {
                    partnersNames.add(partner.name.toLowerCase());
                    return true;
                  });
                  return RawAutocomplete<String>(
                    textEditingController: partnerController,
                    focusNode: FocusNode(),
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      return partnersNames.where((String option) {
                        return option
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    fieldViewBuilder: (BuildContext context, partnerController,
                        focusNode, VoidCallback onFieldSubmitted) {
                      return TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            hintText: "Hint here"),
                        controller: partnerController,
                        focusNode: focusNode,
                        onFieldSubmitted: (String value) {
                          onFieldSubmitted();
                        },
                      );
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<String> onSelected,
                        Iterable<String> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4.0,
                          child: SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8.0),
                              itemCount: state.partners.length,
                              itemBuilder: (BuildContext context, int index) {
                                final String option = options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                    setState(() {
                                      selectedPartner = partners
                                          .where((element) =>
                                              (element.name.toLowerCase() ==
                                                  option.toLowerCase()))
                                          .toList()
                                          .first;
                                    });

                                    Navigator.pop(context, selectedPartner);
                                  },
                                  child: ListTile(
                                    title: Text(option),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              }),
            ),
            IconButton(
              icon: const Icon(Icons.highlight_remove),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
