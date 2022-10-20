import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/profile/widget/profile_photo_widget.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';

import 'bloc/bloc/profile_bloc.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key, required this.userProfile}) : super(key: key);
  final Partner userProfile;
  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late Partner userProfile;

  TextEditingController nameControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController phoneControler = TextEditingController();
  TextEditingController adressControler = TextEditingController();
  TextEditingController websiteControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameControler.text = widget.userProfile.name;
    emailControler.text = widget.userProfile.email;
    phoneControler.text = widget.userProfile.phone;
    adressControler.text = widget.userProfile.address;
    websiteControler.text = widget.userProfile.website;
    userProfile = widget.userProfile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translate("profile.myProfile")),
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoaded) {
                setState(() {
                  userProfile = state.partner;
                });
              }
              if (state is ProfileUpdated) {
                BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(translate("profile.updateSuccess")),
                  ),
                );
              } else if (state is ProfileUpdateFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(translate("profile.updateFailed")),
                  ),
                );
              }
            },
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        Column(children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: ProfilePhotoWidget(
                              key: ValueKey(Random().nextInt(100)),
                              avatar: userProfile.photo,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.send,
                                controller: nameControler,
                                decoration: InputDecoration(
                                  hintText: translate("partner.name"),
                                ),
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                        PatchProfileEvent(value: {
                                      'name': nameControler.text
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.send,
                                controller: emailControler,
                                decoration: InputDecoration(
                                  hintText: translate("partner.mail"),
                                ),
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                        PatchProfileEvent(value: {
                                      "email": emailControler.text
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.send,
                                keyboardType: TextInputType.number,
                                controller: phoneControler,
                                decoration: InputDecoration(
                                  hintText: translate("partner.phone"),
                                ),
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                        PatchProfileEvent(value: {
                                      "phone": phoneControler.text
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.send,
                                controller: adressControler,
                                decoration: InputDecoration(
                                  hintText: translate("partner.address"),
                                ),
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                        PatchProfileEvent(value: {
                                      "address": adressControler.text
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.send,
                                controller: websiteControler,
                                decoration: InputDecoration(
                                  hintText: translate("partner.website"),
                                ),
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                        PatchProfileEvent(value: {
                                      "website": websiteControler.text
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
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
