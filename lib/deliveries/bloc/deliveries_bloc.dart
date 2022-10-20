import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../deliveries_repository.dart';
import '../model/deliveries_list_model.dart';

part 'deliveries_event.dart';
part 'deliveries_state.dart';

class DeliveriesBloc extends Bloc<DeliveriesEvent, DeliveriesState> {
  DeliveriesService deliveriesService;
  DeliveriesBloc({required this.deliveriesService})
      : super(DeliveriesInitial()) {
    on<GetDeliveriesEvent>((event, emit) async {
      emit(DeliveriesLoading());
      try {
        var response = await deliveriesService.fetchDeliveries();
        if (response is DeliveriesListModel) {
          emit(DeliveriesLoaded(deliveries: response.delivery));
        } else {
          emit(const DeliveriesLoadedError(error: ""));
        }
      } catch (e) {
        emit(DeliveriesLoadedError(error: e.toString()));
      }
    });

    on<AddDelivery>((event, emit) async {
      emit(DeliveriesLoading());
      try {
        var response =
            await deliveriesService.addDelivery(event.saleId, event.delivery);
        if (response) {
          emit(AddSaleDeliverySuccess());
        } else {
          emit(const AddSaleDeliveryFailed(error: ""));
        }
      } catch (e) {
        emit(AddSaleDeliveryFailed(error: e.toString()));
      }
    });
    on<DeleteDelivery>((event, emit) async {
      emit(DeliveriesLoading());
      try {
        var response = await deliveriesService.deleteDelivery(event.deliveryId);
        if (response) {
          emit(DeliveryDeleted());
        }
      } catch (e) {
        emit(DeliveryDeletedFailed(error: e.toString()));
      }
    });

    on<PatchDeliveryEvent>((event, emit) async {
      emit(DeliveriesLoading());
      try {
        bool response = await deliveriesService.patchDelivery(
            event.deliveryId, event.updateData);
        if (response) {
          emit(DeliveryUpdated());
        } else {
          emit(DeliveryUpdatedFailed(error: "error"));
        }
      } catch (e) {
        emit(DeliveryUpdatedFailed(error: e.toString()));
      }
    });

    on<PatchDeliveryLineEvent>((event, emit) async {
      emit(DeliveriesLoading());
      try {
        bool response = await deliveriesService.patchDeliveryLine(
            event.deliveryId, event.deliveryLineId, event.updateData);
        if (response) {
          emit(DeliveryLineUpdated());
        } else {
          emit(DeliveryLineUpdatedFailed(error: "error"));
        }
      } catch (e) {
        emit(DeliveryLineUpdatedFailed(error: e.toString()));
      }
    });
  }
}
