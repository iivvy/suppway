import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suppwayy_mobile/lot/bloc/lot_bloc.dart';
import 'package:suppwayy_mobile/manufacturing_product/bloc/manufacturing_product_bloc.dart';
import 'package:suppwayy_mobile/manufacturing_product/models/manufacturing_product_list_model.dart';
import 'package:suppwayy_mobile/profile/bloc/bloc/profile_bloc.dart';

import '../../suppwayy_config.dart';
import '../manufacturing_product_detail_page.dart';

class ManufacturingProductCard extends StatefulWidget {
  const ManufacturingProductCard({Key? key, required this.manufacturingProduct})
      : super(key: key);
  final ManufacturingProduct manufacturingProduct;

  @override
  State<ManufacturingProductCard> createState() =>
      _ManufacturingProductCardState();
}

class _ManufacturingProductCardState extends State<ManufacturingProductCard> {
  late bool authorize;
  @override
  void initState() {
    authorize = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Image productImage = widget.manufacturingProduct.image != ""
        ? Image.network(
            "${SuppWayy.baseUrl}/${widget.manufacturingProduct.image}",
            headers: BlocProvider.of<ManufacturingProductBloc>(context)
                .manufacturingProductsService
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
              .add(GetLotsEvent(productId: widget.manufacturingProduct.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManufacturingProductDetailPage(
                manufacturingProduct: widget.manufacturingProduct,
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
                color: widget.manufacturingProduct.published!
                    ? Colors.greenAccent.shade400
                    : Colors.grey.shade400,
              ),
              SizedBox(
                width: width * 0.90,
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
                    widget.manufacturingProduct.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  subtitle: Text(widget.manufacturingProduct.gtin),
                  trailing: Container(
                    constraints: BoxConstraints(maxWidth: 100.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.manufacturingProduct.quantity.toString(),
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
