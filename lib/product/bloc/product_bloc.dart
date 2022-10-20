import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';
import 'package:suppwayy_mobile/product/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsService productsService;
  ProductBloc({required this.productsService}) : super(ProductsInitialState()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductsLoading());
      try {
        var response = await productsService.fetchProducts();
        if (response is ProductListModel) {
          emit(ProductsLoaded(products: response.products));
        } else {
          emit(const ProductsLoadingError(error: ""));
        }
      } catch (e) {
        // print(e);
        emit(ProductsLoadingError(error: e.toString()));
      }
    });

    on<AddProductEvent>((event, emit) async {
      emit(ProductsLoading());
      try {
        var response = await productsService.addProduct(event.productData);
        if (response) {
          emit(ProductCreated());
        }
      } catch (e) {
        emit(ProductCreationFailed(error: e.toString()));
      }
    });

    on<PatchProduct>((event, emit) async {
      emit(ProductsLoading());
      try {
        var response = await productsService.patchProduct(
            event.productId, event.updatedProductData);
        if (response) {
          emit(PatchSuccess());
        }
      } catch (e) {
        emit(PatchError(error: e.toString()));
      }
    });

    on<DeleteProduct>((event, emit) async {
      emit(ProductsLoading());
      try {
        var response = await productsService.deleteProduct(event.productId);
        if (response) {
          emit(DeleteProductSuccess());
        }
      } catch (e) {
        emit(DeleteProductError(error: e.toString()));
      }
    });

    on<PostNewMediaEvent>((event, emit) async {
      emit(ProductsLoading());
      try {
        var response =
            await productsService.postNewMedia(event.productId, event.photo);

        if (response) {
          emit(ProductMediaPosted());
        } else {
          emit(const ProductMediasLoadingError(error: ""));
        }
      } catch (e) {
        emit(ProductMediasLoadingError(error: e.toString()));
      }
    });

    on<DeletePhotoProduct>((event, emit) async {
      emit(ProductsLoading());
      try {
        var response = await productsService.deletePhotoProduct(
            event.productId, event.photoId);
        if (response) {
          emit(DeletePhotoProductSuccess());
        }
      } catch (e) {
        emit(DeletePhotoProductError(error: e.toString()));
      }
    });
    on<PostProductImage>((event, emit) async {
      emit(ProductsLoading());
      try {
        var response = await productsService.postProductImage(
            event.productId, event.image);

        if (response) {
          emit(PatchSuccess());
        } else {
          emit(const PatchError(error: "Error updating product image"));
        }
      } catch (e) {
        emit(PatchError(error: e.toString()));
      }
    });
  }
}
