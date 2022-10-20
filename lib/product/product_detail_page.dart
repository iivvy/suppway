import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:suppwayy_mobile/product/containers/product_data_tab.dart';
import 'package:suppwayy_mobile/product/containers/product_description_tab.dart';
import 'package:suppwayy_mobile/product/containers/product_lots_tab.dart';
import 'package:suppwayy_mobile/product/containers/product_medias_tab.dart';
import 'package:suppwayy_mobile/utils/choose_photo.dart';
import '../suppwayy_config.dart';
import 'models/product_list_model.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage(
      {Key? key, required this.product, required this.authorize})
      : super(key: key);
  final Product product;
  final bool authorize;
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late bool published;
  late Product product;

  late SlidableButtonPosition position;

  @override
  void initState() {
    product = widget.product;
    published = widget.product.published!;
    if (published) {
      position = SlidableButtonPosition.end;
    } else {
      position = SlidableButtonPosition.start;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Image productImage = product.image != ""
        ? Image.network(
            "${SuppWayy.baseUrl}/${product.image}",
            fit: BoxFit.cover,
            headers: BlocProvider.of<ProductBloc>(context)
                .productsService
                .getHeadersWithAuthorization,
            width: width,
          )
        : Image.asset("assets/images/productImage.jpg",
            width: width, fit: BoxFit.cover);
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductsLoaded) {
          setState(() {
            product =
                state.products.firstWhere((p) => p.id == widget.product.id);
          });
        }
        if (state is PatchSuccess) {
          BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());
                Navigator.of(context).pop();
              }),
          title: Text(product.name),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: height * 0.25,
              width: width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    child: Center(
                      child: SizedBox(
                        height: height * 0.25,
                        child: productImage,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () async {
                          var response = await showChoiceDialog(context);
                          if (response is XFile?) {
                            BlocProvider.of<ProductBloc>(context).add(
                              PostProductImage(
                                productId: widget.product.id!,
                                image: response,
                              ),
                            );
                          }
                        },
                        // color: Colors.accents.,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )),
                  Positioned(
                    bottom: 8,
                    left: 20,
                    child: widget.authorize
                        ? Row(
                            children: [
                              HorizontalSlidableButton(
                                initialPosition: position,
                                width: width / 1.15,
                                buttonWidth: 100.0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5),
                                buttonColor: Theme.of(context).primaryColor,
                                dismissible: false,
                                label: Center(
                                    child: Text(
                                  translate("product.slide"),
                                  style: Theme.of(context).textTheme.headline5,
                                )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        translate("product.Unpublished"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      Text(
                                        translate("product.published"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ],
                                  ),
                                ),
                                onChanged: (position) {
                                  setState(
                                    () {
                                      if (position ==
                                          SlidableButtonPosition.end) {
                                        BlocProvider.of<ProductBloc>(context)
                                            .add(PatchProduct(
                                                productId: widget.product.id!,
                                                updatedProductData: const {
                                              'published': "true"
                                            }));
                                      } else {
                                        BlocProvider.of<ProductBloc>(context)
                                            .add(
                                          PatchProduct(
                                            productId: widget.product.id!,
                                            updatedProductData: const {
                                              'published': "false"
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                        : Container(),
                  )
                ],
              ),
            ),
            SizedBox(
              // TODO cal the exact height
              height: height * 0.58,
              child: DefaultTabController(
                length: 4,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.black26,
                        tabs: [
                          Text(
                            translate("product.details"),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            translate("product.Lots"),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            translate("product.Medias"),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            translate("product.Description"),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      ProductDataTab(product: product),
                      ProductLotsTab(product: product),
                      ProductMediasTab(product: product),
                      ProductDescriptionTab(product: product),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
