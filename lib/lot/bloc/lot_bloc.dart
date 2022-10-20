import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:suppwayy_mobile/lot/models/lot_list_model.dart';
import 'package:suppwayy_mobile/lot/lot_repository.dart';

part 'lot_event.dart';
part 'lot_state.dart';

class LotBloc extends Bloc<LotEvent, LotState> {
  LotsService lotsService;
  LotBloc({required this.lotsService}) : super(LotsInitialState()) {
    on<GetLotsEvent>((event, emit) async {
      emit(LotsLoading());
      try {
        var response = await lotsService.fetchLots(event.productId!);
        if (response is LotListModel) {
          emit(LotsLoaded(lots: response.lots));
        } else {
          emit(const LotsLoadingError(error: ""));
        }
      } catch (e) {
        // print(e);
        emit(LotsLoadingError(error: e.toString()));
      }
    });
    on<AddLotEvent>((event, emit) async {
      emit(LotsLoading());
      try {
        var response = await lotsService.addLot(event.productID, event.lotData);
        if (response) {
          emit(LotCreated());
        } else {
          emit(const LotCreationFailed(error: ""));
        }
      } catch (e) {
        // print(e);
        emit(LotCreationFailed(error: e.toString()));
      }
    });

    on<PatchLotEvent>((event, emit) async {
      emit(LotsLoading());
      try {
        bool response = await lotsService.patchLot(
            event.productID, event.lotID, event.updateData);
        if (response) {
          emit(LotUpdated());
        }
      } catch (e) {
        // print(e);
        emit(LotUpdatedFailed(error: e.toString()));
      }
    });

    on<DeletelotEvent>((event, emit) async {
      emit(LotsLoading());
      try {
        var response =
            await lotsService.deleteLot(event.productID, event.lotID);
        if (response) {
          emit(LotDeleted());
        }
      } catch (e) {
        emit(LotDeletedFailed(error: e.toString()));
      }
    });
  }
}
