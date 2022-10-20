part of 'sale_order_bloc.dart';

abstract class SaleOrderState extends Equatable {
  const SaleOrderState();

  @override
  List<Object> get props => [];
}

/*SALE ORDER STATES START */
class SaleOrderInitialState extends SaleOrderState {}

class SaleOrderLoading extends SaleOrderState {}

class SalesOrderLoaded extends SaleOrderState {
  const SalesOrderLoaded({required this.salesOrder});
  final List<SaleOrder> salesOrder;
  @override
  List<Object> get props => [salesOrder];
}

class SalesOrderLoadingError extends SaleOrderState {
  const SalesOrderLoadingError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class SaleOrderCreated extends SaleOrderState {}

class SaleOrderCreationFailed extends SaleOrderState {
  const SaleOrderCreationFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class SaleOrderUpdated extends SaleOrderState {}

class SaleOrderUpdateFailed extends SaleOrderState {
  const SaleOrderUpdateFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class SaleOrderDeleted extends SaleOrderState {}

class DeleteSaleOrderFailed extends SaleOrderState {
  const DeleteSaleOrderFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

/*SALE ORDER STATES END */

class SaleOrderLineAdded extends SaleOrderState {}

class AddSaleOrderLineFailed extends SaleOrderState {
  const AddSaleOrderLineFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class SaleOrderLineUpdated extends SaleOrderState {}

class UpdateSaleOrderLineFailed extends SaleOrderState {
  const UpdateSaleOrderLineFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class SaleOrderLineDeleted extends SaleOrderState {}

class DeleteSaleOrderLineFailed extends SaleOrderState {
  const DeleteSaleOrderLineFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class PrintSaleOrderError extends SaleOrderState {
  const PrintSaleOrderError({this.error});
  final String? error;
  @override
  List<Object> get props => [error!];
}

class PrintSaleOrderSuccess extends SaleOrderState {
  const PrintSaleOrderSuccess();
  @override
  List<Object> get props => [];
}

class SendEmailError extends SaleOrderState {
  const SendEmailError({this.error});
  final String? error;
  @override
  List<Object> get props => [error!];
}

class SendEmailSuccess extends SaleOrderState {
  const SendEmailSuccess();
  @override
  List<Object> get props => [];
}

class SaleOrderOptionalLineCreated extends SaleOrderState {}

class SaleOrderOptionalLineCreateFailed extends SaleOrderState {
  const SaleOrderOptionalLineCreateFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class SaleOrderOptionalLineDeleted extends SaleOrderState {}

class DeleteSaleOrderOptionalLineFailed extends SaleOrderState {
  const DeleteSaleOrderOptionalLineFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class SaleOrderoptionalLineUpdated extends SaleOrderState {}

class UpdateSaleOrderOptionalLineFailed extends SaleOrderState {
  const UpdateSaleOrderOptionalLineFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
