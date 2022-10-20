import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';

import '../../main_repository.dart';
import '../../suppwayy_config.dart';

class ProductMediasWidget extends StatelessWidget {
  const ProductMediasWidget(
      {Key? key, required this.product, required this.media})
      : super(key: key);
  final Map<String, dynamic> media;
  final Product product;
  @override
  Widget build(BuildContext context) {
    MainRepository mainService = MainRepository();
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return DetailScreen(
            link: SuppWayy.baseUrl + "/${media['url']}",
          );
        }));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              SuppWayy.baseUrl + "/${media['url']}",
              headers: mainService.getHeadersWithAuthorization,
              fit: BoxFit.cover,
              errorBuilder: (c, o, s) {
                return Container(
                  color: Colors.grey,
                  height: width / 3,
                  width: width / 2,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              right: 0,
              child: PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    size: 30,
                    color: Colors.black54,
                  ),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<int>(
                        height: 15,
                        value: 0,
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            Text(translate("lot.delete")),
                          ],
                        ),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 0) {
                      BlocProvider.of<ProductBloc>(context).add(
                          DeletePhotoProduct(
                              productId: product.id!, photoId: media['id']));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.link}) : super(key: key);
  final String link;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(link),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
