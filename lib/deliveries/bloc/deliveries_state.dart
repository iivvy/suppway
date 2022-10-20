part of 'deliveries_bloc.dart';

abstract class DeliveriesState extends Equatable {
  const DeliveriesState();

  @override
  List<Object> get props => [];
}

class DeliveriesInitial extends DeliveriesState {}

class DeliveriesLoading extends DeliveriesState {}

class DeliveriesLoaded extends DeliveriesState {
  const DeliveriesLoaded({required this.deliveries});
  final List<Delivery> deliveries;
}

class DeliveriesLoadedError extends DeliveriesState {
  const DeliveriesLoadedError({required this.error});
  final String error;
}

class AddSaleDeliverySuccess extends DeliveriesState {}

class AddSaleDeliveryFailed extends DeliveriesState {
  const AddSaleDeliveryFailed({required this.error});
  final String error;
}

class DeliveryDeleted extends DeliveriesState {}

class DeliveryDeletedFailed extends DeliveriesState {
  const DeliveryDeletedFailed({required this.error});
  final String error;
}

class DeliveryUpdated extends DeliveriesState {}

class DeliveryUpdatedFailed extends DeliveriesState {
  const DeliveryUpdatedFailed({required this.error});
  final String error;
}

//-----------------Delivery Lines------------------//
class DeliveryLineUpdated extends DeliveriesState {}

class DeliveryLineUpdatedFailed extends DeliveriesState {
  const DeliveryLineUpdatedFailed({required this.error});
  final String error;
}
