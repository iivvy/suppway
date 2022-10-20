import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:suppwayy_mobile/manufacturing_product/models/manufacturing_product_list_model.dart';

import '../manufacturing_product_repository.dart';

part 'manufacturing_product_event.dart';
part 'manufacturing_product_state.dart';

class ManufacturingProductBloc
    extends Bloc<ManufacturingProductEvent, ManufacturingProductState> {
  final ManufacturingProductsService manufacturingProductsService;
  ManufacturingProductBloc({required this.manufacturingProductsService})
      : super(ManufacturingProductInitial()) {
    on<GetManufacturingProductsEvent>((event, emit) async {
      emit(ManufacturingProductsLoading());
      try {
        var response =
            await manufacturingProductsService.fetchManufacturingProducts();
        if (response is ManufacturingProductListModel) {
          emit(ManufacturingProductsLoaded(
              manufacturingProducts: response.manufacturingProducts));
        }
      } catch (e) {
        emit(ManufacturingProductsLoadingError(error: e.toString()));
      }
    });
    on<AddManufacturingProductEvent>((event, emit) async {
      emit(ManufacturingProductsLoading());
      try {
        var response = await manufacturingProductsService
            .addManufacturingProduct(event.manufacturingProductData);
        if (response) {
          emit(ManufacturingProductCreated());
        }
      } catch (e) {
        emit(ManufacturingProductCreationFailed(error: e.toString()));
      }
    });
    on<UpdateManufacturingProductEvent>((event, emit) async {
      emit(ManufacturingProductsLoading());
      try {
        var response =
            await manufacturingProductsService.updateManufacturingProduct(
                event.manufacturingProductId,
                event.updatedManufacturingProductData);
        if (response) {
          emit(ManufacturingProductUpdated());
        }
      } catch (e) {
        emit(UpdateManufacturingProductFailed(error: e.toString()));
      }
    });
    on<DeleteManufacturingProductEvent>(((event, emit) async{
      emit(ManufacturingProductsLoading());
      try{
        var response = await manufacturingProductsService.deleteManufacturingProduct(event.manufacturingProductId);
        if (response){
          emit(ManufacturingProductDeleted());
        }
      }catch(e){
        emit(DeleteManufacturingProductFailed(error: e.toString()));
      }
    } ));
  }
}
