import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/lot/bloc/lot_bloc.dart';
import 'package:suppwayy_mobile/sale/add_sale_order_page.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';
import 'package:suppwayy_mobile/sale/widgets/saleorder_card_widget.dart';
import 'package:suppwayy_mobile/setting/bloc/setting_bloc.dart';
import 'package:suppwayy_mobile/setting/linear_gradient.dart';

class SalesOrderListPage extends StatefulWidget {
  const SalesOrderListPage({Key? key}) : super(key: key);

  @override
  State<SalesOrderListPage> createState() => _SalesOrderListPageState();
}

class _SalesOrderListPageState extends State<SalesOrderListPage> {
  late bool _theme;

  @override
  void initState() {
    BlocProvider.of<SaleOrderBloc>(context).add(GetSalesOrderEvent());
    BlocProvider.of<LotBloc>(context).add(GetLotsEvent());
    _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("salorderpage.title")),
      ),
      body: BlocBuilder<SaleOrderBloc, SaleOrderState>(
        builder: (context, state) {
          if (state is SalesOrderLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              scrollDirection: Axis.vertical,
              itemCount: state.salesOrder.length,
              itemBuilder: (context, index) {
                final saleOrder = state.salesOrder[index];
                return SaleOrderCardWidget(
                  saleOrder: saleOrder,
                );
              },
            );
          } else if (state is SalesOrderLoadingError) {
            return Text(state.error);
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddSaleOrderPage(),
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
}
