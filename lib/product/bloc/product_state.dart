part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductsInitialState extends ProductState {}

class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  const ProductsLoaded({required this.products});
  final List<Product> products;
  @override
  List<Object> get props => [products];
}

class ProductsLoadingError extends ProductState {
  const ProductsLoadingError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class ProductCreated extends ProductState {}

class ProductCreationFailed extends ProductState {
  const ProductCreationFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class PatchSuccess extends ProductState {}

class PatchError extends ProductState {
  const PatchError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class ProductMediaPosted extends ProductState {}

class ProductMediasLoadingError extends ProductState {
  const ProductMediasLoadingError({required this.error});
  final String error;
  @override
  List<Object> get props => [];
}

class DeletePhotoProductSuccess extends ProductState {}

class DeletePhotoProductError extends ProductState {
  const DeletePhotoProductError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class DeleteProductSuccess extends ProductState {}

class DeleteProductError extends ProductState {
  const DeleteProductError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
