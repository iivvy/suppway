part of 'manufacturing_order_bloc.dart';

abstract class ManufacturingOrderState extends Equatable {
  const ManufacturingOrderState();

  @override
  List<Object> get props => [];
}

class ManufacturingOrderInitial extends ManufacturingOrderState {}

class ManufacturingOrderLoading extends ManufacturingOrderState {}

class ManufacturingOrderLoaded extends ManufacturingOrderState {
  const ManufacturingOrderLoaded({required this.manufacturingOrders});
  final List<ManufacturingOrder> manufacturingOrders;
  @override
  List<Object> get props => [manufacturingOrders];
}

class ManufacturingOrderLoadedError extends ManufacturingOrderState {
  const ManufacturingOrderLoadedError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
//------------------------Manufacturing order -----------------------//
//CREATION

class ManufacturingOrderCreated extends ManufacturingOrderState {}

class ManufacturingOrderCreationFailed extends ManufacturingOrderState {
  const ManufacturingOrderCreationFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

//UPDATE
class UpdateManufacturingOrderSuccess extends ManufacturingOrderState {}

class UpdateManufacturingOrderError extends ManufacturingOrderState {
  const UpdateManufacturingOrderError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

// DELETE
class DeleteManufacturingOrderSuccess extends ManufacturingOrderState {}

class DeleteManufacturingOrderError extends ManufacturingOrderState {
  const DeleteManufacturingOrderError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
//-----------------------Manufacturing order line ---------------------//

//CREATION
class ManufacturingOrderLineAdded extends ManufacturingOrderState {}

class AddManufacturingOrderLineFailed extends ManufacturingOrderState {
  const AddManufacturingOrderLineFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

//DELETE
class ManufacturingOrderLineDeleted extends ManufacturingOrderState {}

class DeleteManufacturingOrderLineFailed extends ManufacturingOrderState {
  const DeleteManufacturingOrderLineFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

//UPDATE
class ManufacturingOrderLineUpdated extends ManufacturingOrderState {}

class UpdateManufacturingOrderLinefailed extends ManufacturingOrderState {
  const UpdateManufacturingOrderLinefailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
