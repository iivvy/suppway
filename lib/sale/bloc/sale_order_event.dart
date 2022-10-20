part of 'sale_order_bloc.dart';

abstract class SaleOrderEvent extends Equatable {
  const SaleOrderEvent();

  @override
  List<Object> get props => [];
}
//****sale order START */

class GetSalesOrderEvent extends SaleOrderEvent {}

class AddSaleOrderEvent extends SaleOrderEvent {
  const AddSaleOrderEvent(
      {required this.name,
      required this.comment,
      required this.partner,
      required this.date,
      required this.deliverylocation,
      required this.lines});
  final String name;
  final String comment;
  final Partner partner;
  final DateTime date;
  final int deliverylocation;
  final List<LineData> lines;
  @override
  List<Object> get props => [];
}

class UpdateSaleOrderEvent extends SaleOrderEvent {
  const UpdateSaleOrderEvent({required this.updatedSaleOrderData});
  final Map updatedSaleOrderData;
  @override
  List<Object> get props => [];
}

class PatchSaleOrderEvent extends SaleOrderEvent {
  const PatchSaleOrderEvent(
      {required this.updateData, required this.saleOrderID});
  final int saleOrderID;
  final Map updateData;
  @override
  List<Object> get props => [];
}

class DeleteSaleOrderEvent extends SaleOrderEvent {
  const DeleteSaleOrderEvent({required this.saleOrderID});
  final int saleOrderID;
  @override
  List<Object> get props => [];
}

//****sale order END */

class AddSaleOrderLineEvent extends SaleOrderEvent {
  const AddSaleOrderLineEvent(
      {required this.saleOrderLineData, required this.saleOrderID});

  final int saleOrderID;
  final LineData saleOrderLineData;

  @override
  List<Object> get props => [];
}

class UpdateSaleOrderLineEvent extends SaleOrderEvent {
  const UpdateSaleOrderLineEvent(
      {required this.saleorderLine, required this.saleorderID});

  final LineData saleorderLine;
  final int saleorderID;
  @override
  List<Object> get props => [];
}

class PatchSaleOrderLineEvent extends SaleOrderEvent {
  const PatchSaleOrderLineEvent(
      {required this.updateData,
      required this.saleOrderID,
      required this.saleOrderLineID});
  final int saleOrderID;
  final int saleOrderLineID;
  final Map updateData;
  @override
  List<Object> get props => [];
}

class DeleteSaleOrderLineEvent extends SaleOrderEvent {
  const DeleteSaleOrderLineEvent(
      {required this.saleorderLineID, required this.saleorderID});

  final int saleorderLineID;
  final int saleorderID;
  @override
  List<Object> get props => [];
}

class PrintSaleOrder extends SaleOrderEvent {
  const PrintSaleOrder({required this.saleorderID});
  final int saleorderID;

  @override
  List<Object> get props => [];
}

class SendSaleOrder extends SaleOrderEvent {
  const SendSaleOrder({required this.saleorderID});
  final int saleorderID;

  @override
  List<Object> get props => [];
}

class AddSaleOrderOptionalLineEvent extends SaleOrderEvent {
  const AddSaleOrderOptionalLineEvent({
    required this.saleOrderID,
    required this.saleOrderOptionalLineData,
  });

  final int saleOrderID;
  final SaleOrderOptionalLine saleOrderOptionalLineData;

  @override
  List<Object> get props => [];
}

class DeleteOptionalLine extends SaleOrderEvent {
  const DeleteOptionalLine(
      {required this.saleOrderId, required this.optionalLineId});
  final int saleOrderId;
  final int optionalLineId;
  @override
  List<Object> get props => [];
}

class PatchSaleOrderOptionalLineEvent extends SaleOrderEvent {
  const PatchSaleOrderOptionalLineEvent(
      {required this.updateData,
      required this.saleOrderId,
      required this.saleOrderOptionalLineId});
  final Map updateData;
  final int saleOrderId;
  final int saleOrderOptionalLineId;
  @override
  List<Object> get props => [];
}
