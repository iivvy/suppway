part of 'deliveries_bloc.dart';

abstract class DeliveriesEvent extends Equatable {
  const DeliveriesEvent();

  @override
  List<Object> get props => [];
}

class GetDeliveriesEvent extends DeliveriesEvent {}

class AddDelivery extends DeliveriesEvent {
  const AddDelivery({required this.saleId, required this.delivery});
  final int saleId;
  final Delivery delivery;
}

class DeleteDelivery extends DeliveriesEvent {
  const DeleteDelivery({required this.deliveryId});
  final int deliveryId;
}

class PatchDeliveryEvent extends DeliveriesEvent {
  const PatchDeliveryEvent(
      {required this.updateData, required this.deliveryId});
  final int deliveryId;
  final Map updateData;
}

//-----------------Delivery Lines------------------//

class PatchDeliveryLineEvent extends DeliveriesEvent {
  const PatchDeliveryLineEvent(
      {required this.updateData,
      required this.deliveryId,
      required this.deliveryLineId});
  final int deliveryId;
  final int deliveryLineId;
  final Map updateData;
}
