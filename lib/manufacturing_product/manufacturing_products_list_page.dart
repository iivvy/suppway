import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/manufacturing_product/bloc/manufacturing_product_bloc.dart';
import 'package:suppwayy_mobile/manufacturing_product/widgets/manufacturing_product_card_widget.dart';

import 'add_manufacturing_product_page.dart';

class ManufacturingProductsListPage extends StatefulWidget {
  const ManufacturingProductsListPage({Key? key}) : super(key: key);

  @override
  State<ManufacturingProductsListPage> createState() =>
      _ManufacturingProductsListPageState();
}

class _ManufacturingProductsListPageState
    extends State<ManufacturingProductsListPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ManufacturingProductBloc>(context)
        .add(GetManufacturingProductsEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text('Manufacturing Products'),
      ),
      body: BlocConsumer<ManufacturingProductBloc, ManufacturingProductState>(
        listener: (context, state) {
          if (state is ManufacturingProductCreated) {
            BlocProvider.of<ManufacturingProductBloc>(context)
                .add(GetManufacturingProductsEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("product.createsuccess")),
              ),
            );
          } else if (state is ManufacturingProductCreationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("product.createsuccess")),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ManufacturingProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ManufacturingProductsLoaded) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.vertical,
                itemCount: state.manufacturingProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                  confirmDismiss: (DismissDirection direction) async{
                    return await showDialog(
                      
                      context: context, builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text('delete confirmation'),
                          content: Text('sure you wanna delete this item'),
                          actions: <Widget>[
                            TextButton(
                              onPressed:(){
                            BlocProvider.of<ManufacturingProductBloc>(context)
                            .add(DeleteManufacturingProductEvent(manufacturingProductId:state.manufacturingProducts[index].id!));
                            return Navigator.of(context).pop();
                            },
                            child: const Text('delete')),
                            TextButton(onPressed: ()=>Navigator.of(context).pop(false),
                             child: const Text('cancel'),

                             )
                          ],

                        );
                        
                      }
                      
                      );
                      
                  },
                      key: ValueKey(state.manufacturingProducts[index]),
                      child: ManufacturingProductCard(
                        manufacturingProduct:
                            state.manufacturingProducts[index],
                      ),
                    );}
                    );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddMdnufacturingProductPage(),
            ),
          );
        },
        child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add)),
      ),
    );
  }
}
