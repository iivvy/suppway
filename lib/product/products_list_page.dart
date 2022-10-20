import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/product/add_product_page.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/widgets/product_card_widget.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';
import 'package:suppwayy_mobile/setting/bloc/setting_bloc.dart';
import 'package:suppwayy_mobile/setting/linear_gradient.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({Key? key}) : super(key: key);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  bool isSearching = false;

  //late ProductListModel _productlist;
  List<Product> _filteredproducts = [];
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
            ? Text(translate("product.products"))
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
                    hintText: translate("product.searchproduct"),
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
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductCreated) {
            BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("product.createsuccess")),
              ),
            );
          } else if (state is ProductCreationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("product.createefailed")),
              ),
            );
          }
          if (state is DeleteProductSuccess) {
            BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("product.deletesuccess")),
              ),
            );
          } else if (state is DeleteProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate("product.deletefailed")),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsLoaded) {
            _filteredproducts = state.products;
            if (isSearching == true) {
              _filteredproducts = state.products
                  .where((product) =>
                      product.name.toLowerCase().contains(value.toLowerCase()))
                  .toList();

              return _filteredproducts.isNotEmpty
                  ? ListView.builder(
                      itemCount: _filteredproducts.length,
                      itemBuilder: (context, index) => Dismissible(
                        key: ValueKey(_filteredproducts[index]),
                        confirmDismiss: (direction) =>
                            promptUser(direction, _filteredproducts[index].id!),
                        child: ProductCardWidget(
                          product: _filteredproducts[index],
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            } else {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) => Dismissible(
                  key: ValueKey(state.products[index]),
                  confirmDismiss: (direction) =>
                      promptUser(direction, state.products[index].id!),
                  child: ProductCardWidget(
                    product: state.products[index],
                  ),
                ),
              );
            }
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
              builder: (context) => const AddProductPage(),
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

  Future<bool> promptUser(DismissDirection direction, int productId) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text(translate("product.deleteAlert")),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Ok"),
                onPressed: () {
                  BlocProvider.of<ProductBloc>(context)
                      .add(DeleteProduct(productId: productId));
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
