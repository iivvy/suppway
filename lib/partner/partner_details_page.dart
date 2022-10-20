import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/partner/bloc/partner_bloc.dart';
import 'package:suppwayy_mobile/partner/widgets/user_avatar_widget.dart';

import 'models/partner_list_model.dart';

class PartnerDetailsPage extends StatefulWidget {
  const PartnerDetailsPage({Key? key, required this.partner}) : super(key: key);
  final Partner partner;
  @override
  State<PartnerDetailsPage> createState() => _PartnerDetailsPageState();
}

class _PartnerDetailsPageState extends State<PartnerDetailsPage> {
  late Partner partner;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController.text = widget.partner.name;
    emailController.text = widget.partner.email;
    phoneController.text = widget.partner.phone;
    adressController.text = widget.partner.address;
    websiteController.text = widget.partner.website;
    partner = widget.partner;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PartnerBloc, PartnerState>(
      listener: (context, state) {
        if (state is PartnersLoaded) {
          setState(() {
            partner =
                state.partners.firstWhere((p) => p.id == widget.partner.id);
          });
        } else if (state is PatchPartnerSuccess) {
          BlocProvider.of<PartnerBloc>(context).add(GetPartnersEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate("partner.updatesuccess")),
            ),
          );
        } else if (state is PatchPartnerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate("partner.updatefailed")),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(translate("partner.titledetails")),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: UserAvatarWidget(
                      key: ValueKey(Random().nextInt(100)),
                      avatar: partner.photo,
                      partner: partner),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: nameController,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: translate("partner.name")),
                    onFieldSubmitted: (value) {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<PartnerBloc>(context).add(PatchPartner(
                            partnerId: partner.id,
                            updatedPartnerData: {'name': nameController.text}));
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return translate("error.emptyText");
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.send,
                        controller: emailController,
                        decoration: InputDecoration(
                            label: Text(translate("partner.mail"))),
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<PartnerBloc>(context).add(
                                PatchPartner(
                                    partnerId: widget.partner.id,
                                    updatedPartnerData: {
                                  'email': emailController.text
                                }));
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translate("error.emptyText");
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.send,
                        controller: phoneController,
                        decoration: InputDecoration(
                            label: Text(translate("partner.phone"))),
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<PartnerBloc>(context).add(
                                PatchPartner(
                                    partnerId: widget.partner.id,
                                    updatedPartnerData: {
                                  'phone': phoneController.text
                                }));
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translate("error.emptyText");
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.send,
                        controller: adressController,
                        decoration: InputDecoration(
                            label: Text(translate("partner.address"))),
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<PartnerBloc>(context).add(
                                PatchPartner(
                                    partnerId: widget.partner.id,
                                    updatedPartnerData: {
                                  'address': adressController.text
                                }));
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translate("error.emptyText");
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.send,
                        controller: websiteController,
                        decoration: InputDecoration(
                            label: Text(translate("partner.website"))),
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<PartnerBloc>(context).add(
                              PatchPartner(
                                partnerId: widget.partner.id,
                                updatedPartnerData: {
                                  'website': websiteController.text
                                },
                              ),
                            );
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translate("error.emptyText");
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
