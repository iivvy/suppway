import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';
import 'package:suppwayy_mobile/product/widgets/product_media_widget.dart';
import 'package:suppwayy_mobile/utils/choose_photo.dart';

class ProductMediasTab extends StatelessWidget {
  const ProductMediasTab({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
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
              icon: const Icon(Icons.add),
              onPressed: () async {
                var response = await showChoiceDialog(context);
                if (response is XFile?) {
                  BlocProvider.of<ProductBloc>(context).add(
                    PostNewMediaEvent(photo: response, productId: product.id!),
                  );
                }
              },
            ),
          ),
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductMediaPosted) {
                BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(translate("media.loadedSuccess")),
                  ),
                );
              } else {
                if (state is ProductMediasLoadingError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(translate("media.loadedError")),
                    ),
                  );
                }
              }
              if (state is DeletePhotoProductSuccess) {
                BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(translate("media.deleteSuccess")),
                  ),
                );
              } else {
                if (state is DeletePhotoProductError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(translate("media.deleteError")),
                    ),
                  );
                }
              }
              if (state is ProductsLoading) {
                const Center(child: CircularProgressIndicator());
              }
            },
            builder: (context, state) {
              if (state is ProductsLoaded) {
                List<Map<String, dynamic>> productMedias = state.products
                    .firstWhere((p) => p.id == product.id)
                    .medias!;
                return SizedBox(
                  height: height * 0.47,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      children: productMedias
                          .map((media) => ProductMediasWidget(
                                product: product,
                                media: media,
                              ))
                          .toList(),
                    ),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
