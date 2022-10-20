import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/deliveries/sale_deliveries_list_page.dart';
import 'package:suppwayy_mobile/manufacturing/bloc/manufacturing_order_bloc.dart';
import 'package:suppwayy_mobile/manufacturing/manufacturing_list_page.dart';
import 'package:suppwayy_mobile/sale/sales_order_list_page.dart';
import 'package:suppwayy_mobile/commons/drawer_widget.dart';
import 'package:suppwayy_mobile/setting/bloc/setting_bloc.dart';
import 'package:suppwayy_mobile/setting/linear_gradient.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _theme;

  @override
  void initState() {
    super.initState();
    _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("app_bar.homepagetitle")),
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          scrollDirection: Axis.vertical,
          childAspectRatio: 1.0,
          children: <Widget>[
            Column(
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SalesOrderListPage(),
                    ),
                  ),
                  child: Container(
                    height: width / 2 - 50,
                    width: width / 2 - 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      gradient: colorGradient(_theme),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Center(
                      child: Icon(
                        Icons.file_copy,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(4.0)),
                Text(translate("sale.sales"))
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeliveriesPage(),
                    ),
                  ),
                  child: Container(
                    height: width / 2 - 50,
                    width: width / 2 - 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      gradient: colorGradient(_theme),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Center(
                      child: Icon(
                        Icons.local_shipping_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(4.0)),
                Text(translate("deliveries.title"))
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    BlocProvider.of<ManufacturingOrderBloc>(context)
                        .add(GetManufactoringOrderEvent());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ManufacturingOrderPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: width / 2 - 50,
                    width: width / 2 - 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      gradient: colorGradient(_theme),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Center(
                      child: Icon(
                        Icons.precision_manufacturing_sharp,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(4.0)),
                Text(translate("manufacturing.title"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
