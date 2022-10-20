part of 'manufacturing_product_bloc.dart';

abstract class ManufacturingProductEvent extends Equatable {
  const ManufacturingProductEvent();

  @override
  List<Object> get props => [];
}

class GetManufacturingProductsEvent extends ManufacturingProductEvent {}

class AddManufacturingProductEvent extends ManufacturingProductEvent {
  const AddManufacturingProductEvent({required this.manufacturingProductData});
  final ManufacturingProduct manufacturingProductData;
  @override
  List<Object> get props => [];
}

class UpdateManufacturingProductEvent extends ManufacturingProductEvent {
  const UpdateManufacturingProductEvent(
      {required this.manufacturingProductId,
      required this.updatedManufacturingProductData});
  final int manufacturingProductId;
  final Map updatedManufacturingProductData;
  @override
  List<Object> get props => [];
}

class DeleteManufacturingProductEvent extends ManufacturingProductEvent {
  const DeleteManufacturingProductEvent({required this.manufacturingProductId});
  final int manufacturingProductId;
  @override
  List<Object> get props => [];
}
