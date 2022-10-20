class ManufacturingLineData {
  int? id;
  // Product? product;
  // String bom;
  // Lot? rawProductsLots;
  // Lot? finishedProductsLots;
  int quantity;

  ManufacturingLineData({
    this.id,
    required this.quantity,
    // required this.bom,
    // this.rawProductsLots,
    // this.finishedProductsLots,
    // this.product,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'bom': bom,
      // 'rawProductsLots': rawProductsLots!.id,
      // 'finishedProductsLots': finishedProductsLots!.id,
      // 'product': product,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    // return 'ManufacturingLineData(id: $id, product:${product!.id} ,quantity:$quantity, rawProductsLots:${rawProductsLots!.id},finishedProductsLots:${finishedProductsLots!.id}, bom: $bom  )';
    return 'ManufacturingLineData(id: $id,quantity:$quantity)';
  }
}
