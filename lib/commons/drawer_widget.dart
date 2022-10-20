import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/authentication/bloc/authentication_bloc.dart';
import 'package:suppwayy_mobile/manufacturing_product/manufacturing_products_list_page.dart';
import 'package:suppwayy_mobile/profile/bloc/bloc/profile_bloc.dart';
import 'package:suppwayy_mobile/location/bloc/location_bloc.dart';
import 'package:suppwayy_mobile/partner/bloc/partner_bloc.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';
import 'package:suppwayy_mobile/profile/profile_page.dart';
import 'package:suppwayy_mobile/location/locations_list_page.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/products_list_page.dart';
import 'package:suppwayy_mobile/partner/partners_list_page.dart';
import 'package:suppwayy_mobile/setting/bloc/setting_bloc.dart';
import 'package:suppwayy_mobile/setting/linear_gradient.dart';
import 'package:suppwayy_mobile/setting/setting_page.dart';

import '../suppwayy_config.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

late bool _theme;

class _DrawerWidgetState extends State<DrawerWidget> {
  late Partner user;
  @override
  void initState() {
    user = const Partner(
        id: 0,
        name: '',
        phone: '',
        address: '',
        email: '',
        website: '',
        status: '',
        photo: '',
        stripeId: '');
    super.initState();
    _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          user = state.partner;
        }
        return Drawer(
            child: ListView(
          children: [
            DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(gradient: colorGradient(_theme)),
                  margin: EdgeInsets.zero,
                  accountName: Text(user.name,
                      style: const TextStyle(color: Colors.white)),
                  accountEmail: Text(user.email,
                      style: const TextStyle(color: Colors.white)),
                  currentAccountPicture: user.photo.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage("${SuppWayy.baseUrl}/${user.photo}"),
                        )
                      : const CircleAvatar(
                          radius: 30.0,
                          backgroundImage:
                              AssetImage("assets/images/avatar.png"),
                        ),
                  onDetailsPressed: () => {
                    BlocProvider.of<ProfileBloc>(context)
                        .add(GetProfileEvent()),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilPage(userProfile: user),
                        ))
                  },
                )),
            ListTile(
              onTap: () {
                BlocProvider.of<LocationBloc>(context).add(GetLocationsEvent());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationListPage(),
                  ),
                );
              },
              leading: Icon(Icons.location_on),
              title: Text(
                translate("drawer.mylocation"),
              ),
            ),
            ListTile(
              onTap: () {
                BlocProvider.of<PartnerBloc>(context).add(GetPartnersEvent());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PartnersListPage(),
                  ),
                );
              },
              leading: Icon(Icons.contacts),
              title: Text(
                translate("drawer.mycontacts"),
              ),
            ),
            ListTile(
              onTap: () {
                BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductsListPage(),
                  ),
                );
              },
              leading: Icon(Icons.card_giftcard),
              title: Text(
                translate("drawer.myproducts"),
              ),
            ),
            ListTile(
              onTap: () {
                BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManufacturingProductsListPage(),
                  ),
                );
              },
              leading: Icon(Icons.precision_manufacturing),
              title: Text(
                'Manufacturing Products',
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                BlocProvider.of<SettingBloc>(context).add(
                  GetSavedSettings(),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ),
                );
              },
              leading: Icon(Icons.settings),
              title: Text(
                translate("drawer.setting"),
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                showDeleteAlert(context);
                // BlocProvider.of<SettingBloc>(context).add(
                //   GetSavedSettings(),
                // );
              },
              leading: Icon(Icons.logout),
              title: Text(
                translate("drawer.logout"),
              ),
            ),
          ],
        ));
      },
    );
  }

  void showDeleteAlert(BuildContext context) async {
    await showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Text(translate("drawer.confirmLogout")),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("Ok"),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LogOut());
            },
          ),
          CupertinoDialogAction(
            child: Text(translate("sale.button.cancel")),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
