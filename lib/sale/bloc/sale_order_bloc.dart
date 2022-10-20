import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:suppwayy_mobile/sale/models/line_data.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_optional_line_model.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';
import 'package:suppwayy_mobile/sale/models/sale_order_list_model.dart';
import 'package:suppwayy_mobile/sale/sale_order_repository.dart';

part 'sale_order_event.dart';
part 'sale_order_state.dart';

class SaleOrderBloc extends Bloc<SaleOrderEvent, SaleOrderState> {
  final SaleOrderService saleOrderService;
  SaleOrderBloc({required this.saleOrderService})
      : super(SaleOrderInitialState()) {
    on<GetSalesOrderEvent>((event, emit) async {
      emit(SaleOrderLoading());
      try {
        var response = await saleOrderService.fetchSalesOrder();
        if (response is SaleOrderListModel) {
          emit(SalesOrderLoaded(salesOrder: response.salesOrders));
        } else {
          emit(const SalesOrderLoadingError(error: ""));
        }
      } catch (e) {
        // print(e);
        emit(SalesOrderLoadingError(error: e.toString()));
      }
    });

    on<AddSaleOrderEvent>((event, emit) async {
      emit(SaleOrderLoading());
      try {
        Map<String, dynamic> response = await saleOrderService.addSaleOrder(
            event.lines,
            event.name,
            event.comment,
            event.partner,
            event.date,
            event.deliverylocation);
        if (response["success"] == true) {
          emit(SaleOrderCreated());
        } else {
          emit(SaleOrderCreationFailed(error: response["message"]));
        }
      } catch (e) {
        emit(SaleOrderCreationFailed(error: e.toString()));
      }
    });

    on<UpdateSaleOrderEvent>((event, emit) async {
      emit(SaleOrderLoading());
      try {
        Map<String, dynamic> response =
            await saleOrderService.updateSaleOrder(event.updatedSaleOrderData);
        if (response["success"] == true) {
          emit(SaleOrderUpdated());
        } else {
          emit(SaleOrderUpdateFailed(error: response["message"]));
        }
      } catch (e) {
        // print(e);
        emit(SaleOrderUpdateFailed(error: e.toString()));
      }
    });

    on<PatchSaleOrderEvent>((event, emit) async {
      emit(SaleOrderLoading());
      try {
        Map<String, dynamic> response = await saleOrderService.patchSaleOrder(
            event.saleOrderID, event.updateData);
        if (response["success"] == true) {
          emit(SaleOrderUpdated());
        } else {
          emit(SaleOrderUpdateFailed(error: response["message"]));
        }
      } catch (e) {
        // print(e);
        emit(SaleOrderUpdateFailed(error: e.toString()));
      }
    });

    on<DeleteSaleOrderEvent>((event, emit) async {
      try {
        Map<String, dynamic> response =
            await saleOrderService.deleteSaleOrder(event.saleOrderID);
        if (response["success"] == true) {
          emit(SaleOrderDeleted());
        } else {
          emit(DeleteSaleOrderFailed(error: response["message"]));
        }
      } catch (e) {
        emit(DeleteSaleOrderFailed(error: e.toString()));
      }
    });

    on<AddSaleOrderLineEvent>((event, emit) async {
      emit(SaleOrderLoading());
      try {
        Map<String, dynamic> response = await saleOrderService.addSaleOrderLine(
            event.saleOrderID, event.saleOrderLineData);
        if (response["success"] == true) {
          emit(SaleOrderLineAdded());
        } else {
          emit(AddSaleOrderLineFailed(error: response["message"]));
        }
      } catch (e) {
        // print(e);
        emit(AddSaleOrderLineFailed(error: e.toString()));
      }
    });

    on<UpdateSaleOrderLineEvent>((event, emit) async {
      emit(SaleOrderLoading());
      try {
        Map<String, dynamic> response = await saleOrderService
            .updateSaleOrderLine(event.saleorderID, event.saleorderLine);
        if (response["success"] == true) {
          emit(SaleOrderLineUpdated());
        } else {
          emit(UpdateSaleOrderLineFailed(error: response["message"]));
        }
      } catch (e) {
        // print(e);
        emit(UpdateSaleOrderLineFailed(error: e.toString()));
      }
    });

    on<PatchSaleOrderLineEvent>((event, emit) async {
      emit(SaleOrderLoading());
      try {
        Map<String, dynamic> response =
            await saleOrderService.patchSaleOrderLine(
                event.saleOrderID, event.saleOrderLineID, event.updateData);
        if (response["success"] == true) {
          emit(SaleOrderLineUpdated());
        } else {
          emit(UpdateSaleOrderLineFailed(error: response["message"]));
        }
      } catch (e) {
        // print(e);
        emit(UpdateSaleOrderLineFailed(error: e.toString()));
      }
    });

    on<DeleteSaleOrderLineEvent>((event, emit) async {
      try {
        Map<String, dynamic> response = await saleOrderService
            .deleteSaleOrderLine(event.saleorderID, event.saleorderLineID);
        if (response["success"] == true) {
          emit(SaleOrderLineDeleted());
        } else {
          emit(DeleteSaleOrderLineFailed(error: response["message"]));
        }
      } catch (e) {
        emit(DeleteSaleOrderLineFailed(error: e.toString()));
      }
    });

    on<PrintSaleOrder>((event, emit) async {
      emit(SaleOrderLoading());
      try {
        Map<String, dynamic> response =
            await saleOrderService.printSaleOrder(event.saleorderID);

        if (response["success"] == true) {
          emit(const PrintSaleOrderSuccess());
        } else {
          emit(const PrintSaleOrderError());
        }
      } catch (e) {
        emit(PrintSaleOrderError(error: e.toString()));
      }
    });
    on<SendSaleOrder>((event, emit) async {
      emit(SaleOrderLoading());
      try {
        Map<String, dynamic> response =
            await saleOrderService.sendEmailSaleOrder(event.saleorderID);

        if (response["success"] == true) {
          emit(const SendEmailSuccess());
        } else {
          emit(const SendEmailError());
        }
      } catch (e) {
        emit(SendEmailError(error: e.toString()));
      }
    });
    on<AddSaleOrderOptionalLineEvent>((event, emit) async {
      emit(SaleOrderLoading());
      try {
        Map<String, dynamic> response =
            await saleOrderService.addSaleOrderOptionalLine(
                event.saleOrderID, event.saleOrderOptionalLineData);
        if (response["success"] == true) {
          emit(SaleOrderOptionalLineCreated());
        } else {
          emit(SaleOrderOptionalLineCreateFailed(error: response["message"]));
        }
      } catch (e) {
        // print(e);
        emit(SaleOrderOptionalLineCreateFailed(error: e.toString()));
      }
    });
    on<PatchSaleOrderOptionalLineEvent>((event, emit) async {
      emit(SaleOrderLoading());
      try {
        bool response = await saleOrderService.patchOptionalLine(
            event.saleOrderId, event.saleOrderOptionalLineId, event.updateData);
        if (response) {
          emit(SaleOrderoptionalLineUpdated());
        }
      } catch (e) {
        // print(e);
        emit(UpdateSaleOrderOptionalLineFailed(error: e.toString()));
      }
    });

    on<DeleteOptionalLine>((event, emit) async {
      emit(SaleOrderLoading());
      try {
        var response = await saleOrderService.deleteOptionalLine(
            event.saleOrderId, event.optionalLineId);
        if (response) {
          emit(SaleOrderOptionalLineDeleted());
        }
      } catch (e) {
        emit(DeleteSaleOrderOptionalLineFailed(error: e.toString()));
      }
    });
  }
}
