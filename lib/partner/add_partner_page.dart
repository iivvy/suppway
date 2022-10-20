import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/partner/bloc/partner_bloc.dart';

import 'models/partner_list_model.dart';

class AddPartnerPage extends StatefulWidget {
  const AddPartnerPage({Key? key}) : super(key: key);
  @override
  State<AddPartnerPage> createState() => _AddPartnerPageState();
}

class _AddPartnerPageState extends State<AddPartnerPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("partner.addcontact")),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              size: 30,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<PartnerBloc>(context).add(AddPartnerEvent(
                    partnerData: Partner(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        address: adressController.text,
                        website: websiteController.text,
                        id: 0,
                        photo: '',
                        status: '',
                        stripeId: '')));
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration:
                      InputDecoration(label: Text(translate("partner.name"))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration:
                      InputDecoration(label: Text(translate("partner.mail"))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  decoration:
                      InputDecoration(label: Text(translate("partner.phone"))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: adressController,
                  decoration: InputDecoration(
                      label: Text(translate("partner.address"))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translate("error.emptyText");
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: websiteController,
                  decoration: InputDecoration(
                      label: Text(translate("partner.website"))),
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
        ),
      ),
    );
  }
}
