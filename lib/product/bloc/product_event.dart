part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  const AddProductEvent({required this.productData});

  final Product productData;

  @override
  List<Object> get props => [];
}

class PatchProduct extends ProductEvent {
  const PatchProduct(
      {required this.productId, required this.updatedProductData});
  final int productId;
  final Map updatedProductData;
  @override
  List<Object> get props => [];
}

class PostNewMediaEvent extends ProductEvent {
  const PostNewMediaEvent({
    required this.productId,
    required this.photo,
  });
  final int productId;
  final XFile? photo;
}

class DeletePhotoProduct extends ProductEvent {
  const DeletePhotoProduct({required this.productId, required this.photoId});
  final int productId;
  final int photoId;
  @override
  List<Object> get props => [];
}

class PostProductImage extends ProductEvent {
  const PostProductImage({required this.productId, required this.image});
  final int productId;
  final XFile? image;
}

class DeleteProduct extends ProductEvent {
  const DeleteProduct({required this.productId});
  final int productId;
  @override
  List<Object> get props => [];
}
