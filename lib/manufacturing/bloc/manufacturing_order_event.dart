part of 'manufacturing_order_bloc.dart';

abstract class ManufacturingOrderEvent extends Equatable {
  const ManufacturingOrderEvent();

  @override
  List<Object> get props => [];
}

class GetManufactoringOrderEvent extends ManufacturingOrderEvent {}

class AddManufacturingOrderEvent extends ManufacturingOrderEvent {
  const AddManufacturingOrderEvent(
      {
      // required this.manufacturingOrderData
      required this.date,
      required this.status,
      required this.name,
      required this.lines});
  final String name;
  final List<ManufacturingLineData> lines;
  final String status;
  final DateTime date;
  // final ManufacturingOrder manufacturingOrderData;
  @override
  List<Object> get props => [];
}

class DeleteManufacturingOrderEvent extends ManufacturingOrderEvent {
  const DeleteManufacturingOrderEvent({required this.manufacturingOrderID});
  final int manufacturingOrderID;
  @override
  List<Object> get props => [];
}

class UpdateManufacturingOrderEvent extends ManufacturingOrderEvent {
  const UpdateManufacturingOrderEvent(
      {required this.manufacturingOrderID,
      required this.updateManufacturingOrderData});
  final Map updateManufacturingOrderData;
  final int manufacturingOrderID;
  @override
  List<Object> get props => [];
}
//---------------------Manufacturing order line ---------------------//

class AddManufacturingOrderLineEvent extends ManufacturingOrderEvent {
  const AddManufacturingOrderLineEvent(
      {required this.quantity,
      // required this.bom,
      // this.rawProductsLots,
      // this.finishedProductsLots,
      // this.product,
      required this.manufacturingOrderID});
  // final Product? product;
  // final String bom;
  // final Lot? rawProductsLots;
  // final Lot? finishedProductsLots;
  final int quantity;
  final int manufacturingOrderID;

  @override
  List<Object> get props => [];
}

class UpdateManufacturingOrderLineEvent extends ManufacturingOrderEvent {
  const UpdateManufacturingOrderLineEvent(
      {required this.manufacturingOrderLineID,
      required this.manufacturingOrderID,
      required this.updateData});
  final int manufacturingOrderLineID;
  final int manufacturingOrderID;
  final Map updateData;
  @override
  List<Object> get props => [];
}

class DeleteManufacturingOrderLineEvent extends ManufacturingOrderEvent {
  const DeleteManufacturingOrderLineEvent(
      {required this.manufacturingOrderID,
      required this.manufacturingOrderLineID});
  final int manufacturingOrderID;
  final int manufacturingOrderLineID;
}
