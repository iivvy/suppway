import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/lot/bloc/lot_bloc.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';
import 'package:suppwayy_mobile/product/product_lot_add_page.dart';
import 'package:suppwayy_mobile/product/widgets/lot_card_widget.dart';

class ProductLotsTab extends StatefulWidget {
  const ProductLotsTab({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductLotsTab> createState() => _ProductLotsTabState();
}

class _ProductLotsTabState extends State<ProductLotsTab> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: BlocConsumer<LotBloc, LotState>(
        listener: (context, state) {
          if (state is LotCreated) {
            BlocProvider.of<LotBloc>(context)
                .add(GetLotsEvent(productId: widget.product.id));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("lot.createsuccess")),
              ),
            );
          } else if (state is LotCreationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("lot.createfailed")),
              ),
            );
          }
          if (state is LotUpdated) {
            BlocProvider.of<LotBloc>(context)
                .add(GetLotsEvent(productId: widget.product.id));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("lot.updatesuccess")),
              ),
            );
          } else if (state is LotUpdatedFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("lot.updatefailed")),
              ),
            );
          }
          if (state is LotDeleted) {
            BlocProvider.of<LotBloc>(context)
                .add(GetLotsEvent(productId: widget.product.id));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("lot.deletesuccess")),
              ),
            );
          } else if (state is LotDeletedFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("lot.deletefailed")),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LotsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LotsLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      height: height * 0.05,
                      width: width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductLotAddPage(
                                      product: widget.product)))
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.45,
                  child: ListView.builder(
                    itemCount: state.lots.length,
                    itemBuilder: (context, index) => Center(
                      child: LotCardWidget(
                          lot: state.lots[index], product: widget.product),
                    ),
                  ),
                )
              ],
            );
          }
          return Center(
            child: Text(translate("optionalLine.error")),
          );
        },
      ),
    );
  }
}
