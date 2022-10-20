import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suppwayy_mobile/manufacturing_product/bloc/manufacturing_product_bloc.dart';
import 'package:suppwayy_mobile/manufacturing_product/containers/manufacturing_product_data_tab.dart';
import 'package:suppwayy_mobile/manufacturing_product/containers/manufacturing_product_media_tab.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/utils/choose_photo.dart';
import '../suppwayy_config.dart';
import 'containers/manufacturing_product_description_tab.dart';
import 'containers/manufacturing_product_lot_tab.dart';
import 'models/manufacturing_product_list_model.dart';

class ManufacturingProductDetailPage extends StatefulWidget {
  const ManufacturingProductDetailPage(
      {Key? key, required this.manufacturingProduct})
      : super(key: key);
  final ManufacturingProduct manufacturingProduct;
  @override
  State<ManufacturingProductDetailPage> createState() =>
      _ManufacturingProductDetailPageState();
}

class _ManufacturingProductDetailPageState
    extends State<ManufacturingProductDetailPage> {
  TextEditingController nameController = TextEditingController();
  late ManufacturingProduct manufacturingProduct;
  @override
  void initState() {
    super.initState();
    manufacturingProduct = widget.manufacturingProduct;
    nameController = TextEditingController(text: manufacturingProduct.name);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Image productImage = manufacturingProduct.image != ""
        ? Image.network(
            "${SuppWayy.baseUrl}/${manufacturingProduct.image}",
            fit: BoxFit.cover,
            headers: BlocProvider.of<ManufacturingProductBloc>(context)
                .manufacturingProductsService
                .getHeadersWithAuthorization,
            width: width,
          )
        : Image.asset("assets/images/productImage.jpg",
            width: width, fit: BoxFit.cover);
    return BlocListener<ManufacturingProductBloc, ManufacturingProductState>(
      listener: (context, state) {
        if (state is ManufacturingProductsLoaded) {
          setState(() {
            manufacturingProduct = state.manufacturingProducts
                .firstWhere((p) => p.id == widget.manufacturingProduct.id);
          });
        }
        if (state is ManufacturingProductUpdated) {
          BlocProvider.of<ManufacturingProductBloc>(context)
              .add(GetManufacturingProductsEvent());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: nameController,
            style: Theme.of(context).appBarTheme.titleTextStyle,
            onSubmitted: (value) {
              BlocProvider.of<ManufacturingProductBloc>(context).add(
                  UpdateManufacturingProductEvent(
                      manufacturingProductId: widget.manufacturingProduct.id!,
                      updatedManufacturingProductData: {"name": value}));
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                                productId: widget.manufacturingProduct.id!,
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
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
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
                              translate("product.Description"),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              translate("product.Medias"),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        ManufacturingProductDataTab(
                          manufacturingProduct: manufacturingProduct,
                        ),
                        ManufacturingProductLotTab(
                            manufacturingProduct: manufacturingProduct),
                        ManufacturingProductDescriptionTab(
                          manufacturingProduct: manufacturingProduct,
                        ),
                        ManufacturingProductMediaTab(
                          manufacturingProduct: manufacturingProduct,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
