import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suppwayy_mobile/lot/bloc/lot_bloc.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';
import 'package:suppwayy_mobile/profile/bloc/bloc/profile_bloc.dart';

import '../../suppwayy_config.dart';
import '../product_detail_page.dart';

// ignore: must_be_immutable
class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  late bool authorize;
  @override
  void initState() {
    authorize = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    Image productImage = widget.product.image != ""
        ? Image.network("${SuppWayy.baseUrl}/${widget.product.image}",
            headers: BlocProvider.of<ProductBloc>(context)
                .productsService
                .getHeadersWithAuthorization)
        : Image.asset(
            "assets/images/product.png",
            color: Theme.of(context).iconTheme.color,
            height: 70,
          );
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoaded) {
        if (state.partner.stripeId != "") {
          authorize = true;
        }
      }

      return InkWell(
        onTap: () {
          BlocProvider.of<LotBloc>(context)
              .add(GetLotsEvent(productId: widget.product.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                product: widget.product,
                authorize: authorize,
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 4.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 70.0,
                width: 10.0,
                color: widget.product.published!
                    ? Colors.greenAccent.shade400
                    : Colors.grey.shade400,
              ),
              SizedBox(
                width: width * 0.95,
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: productImage.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  subtitle: Text(widget.product.gtin),
                  trailing: Container(
                    constraints: BoxConstraints(maxWidth: 100.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.product.quantity.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
