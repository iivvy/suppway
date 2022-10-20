import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';

class LineData {
  int? id;
  String name;
  int quantity;
  double price;
  Product product;
  Lot lot;
  double taxe;
  double discount;
  LineData(
      {required this.name,
      required this.quantity,
      required this.price,
      required this.product,
      required this.taxe,
      required this.discount,
      required this.lot,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'discount': discount,
      'taxe': taxe,
      'product': product.toMap(),
      'lot': lot.id,
    };
  }

  @override
  String toString() {
    return 'LineData(id: $id, name: $name, quantity: $quantity, price: $price, product:${product.id}, lot:${lot.id},taxe:$taxe, discount:$discount)';
  }
}
