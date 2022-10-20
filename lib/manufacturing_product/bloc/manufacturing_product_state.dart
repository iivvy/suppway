part of 'manufacturing_product_bloc.dart';

abstract class ManufacturingProductState extends Equatable {
  const ManufacturingProductState();

  @override
  List<Object> get props => [];
}

class ManufacturingProductInitial extends ManufacturingProductState {}

class ManufacturingProductsLoading extends ManufacturingProductState {}

class ManufacturingProductsLoaded extends ManufacturingProductState {
  const ManufacturingProductsLoaded({required this.manufacturingProducts});
  final List<ManufacturingProduct> manufacturingProducts;
  @override
  List<Object> get props => [manufacturingProducts];
}

class ManufacturingProductsLoadingError extends ManufacturingProductState {
  const ManufacturingProductsLoadingError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class ManufacturingProductCreated extends ManufacturingProductState {}

class ManufacturingProductCreationFailed extends ManufacturingProductState {
  const ManufacturingProductCreationFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class ManufacturingProductUpdated extends ManufacturingProductState {}

class UpdateManufacturingProductFailed extends ManufacturingProductState {
  const UpdateManufacturingProductFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class ManufacturingProductDeleted extends ManufacturingProductState {}

class DeleteManufacturingProductFailed extends ManufacturingProductState {
  const DeleteManufacturingProductFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
