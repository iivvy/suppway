import 'package:bloc/bloc.dart';
import 'package:suppwayy_mobile/manufacturing/manufacturing_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:suppwayy_mobile/manufacturing/models/line_data.dart';
import 'package:suppwayy_mobile/manufacturing/models/manufacturing_order_list_model.dart';
part 'manufacturing_order_event.dart';
part 'manufacturing_order_state.dart';

class ManufacturingOrderBloc
    extends Bloc<ManufacturingOrderEvent, ManufacturingOrderState> {
  final ManufacturingOrderService manufacturingOrderService;
  ManufacturingOrderBloc({required this.manufacturingOrderService})
      : super(ManufacturingOrderInitial()) {
    on<GetManufactoringOrderEvent>((event, emit) async {
      emit(ManufacturingOrderLoading());
      try {
        var response =
            await manufacturingOrderService.fetchManufacturingOrder();
        if (response is ManufacturingOrderListModel) {
          emit(ManufacturingOrderLoaded(
              manufacturingOrders: response.manufacturingOrders));
        } else {
          emit(const ManufacturingOrderLoadedError(error: ""));
        }
      } catch (e) {
        // print(e);
        emit(ManufacturingOrderLoadedError(error: e.toString()));
      }
    });
    on<AddManufacturingOrderEvent>((event, emit) async {
      emit(ManufacturingOrderLoading());
      try {
        var response = await manufacturingOrderService.addManufacturingOrder(
            event.lines, event.name, event.date, event.status);
        if (response) {
          emit(ManufacturingOrderCreated());
        } else {
          emit(ManufacturingOrderCreationFailed(error: "error"));
        }
      } catch (e) {
        // print(e);
        emit(ManufacturingOrderCreationFailed(error: e.toString()));
      }
    });
    on<DeleteManufacturingOrderEvent>((event, emit) async {
      try {
        var response = await manufacturingOrderService
            .deleteManufacturingOrder(event.manufacturingOrderID);
        if (response) {
          emit(DeleteManufacturingOrderSuccess());
        }
      } catch (e) {
        // print(e);
        emit(DeleteManufacturingOrderError(error: e.toString()));
      }
    });
    on<UpdateManufacturingOrderEvent>((event, emit) async {
      emit(ManufacturingOrderLoading());
      try {
        var response = await manufacturingOrderService.patchManufacturingOrder(
            event.manufacturingOrderID, event.updateManufacturingOrderData);
        if (response) {
          emit(UpdateManufacturingOrderSuccess());
        }
      } catch (e) {
        // print(e);
        emit(UpdateManufacturingOrderError(error: e.toString()));
      }
    });
    on<AddManufacturingOrderLineEvent>((event, emit) async {
      emit(ManufacturingOrderLoading());
      try {
        var response =
            await manufacturingOrderService.addManufacturingOrderLine(
                event.manufacturingOrderID, event.quantity);
        if (response) {
          emit(ManufacturingOrderLineAdded());
        }
      } catch (e) {
        // print(e);
        emit(AddManufacturingOrderLineFailed(error: e.toString()));
      }
    });
    on<DeleteManufacturingOrderLineEvent>((event, emit) async {
      try {
        var response =
            await manufacturingOrderService.deleteManufacturingOrderLine(
                event.manufacturingOrderID, event.manufacturingOrderLineID);
        if (response) {
          emit(ManufacturingOrderLineDeleted());
        }
      } catch (e) {
        emit(DeleteManufacturingOrderLineFailed(error: e.toString()));
      }
    });
    on<UpdateManufacturingOrderLineEvent>((event, emit) async {
      try {
        var response =
            await manufacturingOrderService.updateManufacturingOrderLine(
                event.manufacturingOrderID,
                event.manufacturingOrderLineID,
                event.updateData);
        if (response) {
          emit(ManufacturingOrderLineUpdated());
        }
      } catch (e) {
        emit(UpdateManufacturingOrderLinefailed(error: e.toString()));
      }
    });
  }
}
