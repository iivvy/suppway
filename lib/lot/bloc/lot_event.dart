part of 'lot_bloc.dart';

abstract class LotEvent extends Equatable {
  const LotEvent();

  @override
  List<Object> get props => [];
}

class GetLotsEvent extends LotEvent {
  const GetLotsEvent({this.productId});
  final int? productId;
}

class AddLotEvent extends LotEvent {
  const AddLotEvent({required this.lotData, required this.productID});

  final int productID;
  final Lot lotData;

  @override
  List<Object> get props => [];
}

class PatchLotEvent extends LotEvent {
  const PatchLotEvent(
      {required this.updateData, required this.productID, required this.lotID});
  final int productID;
  final int lotID;
  final Map updateData;
  @override
  List<Object> get props => [];
}

class DeletelotEvent extends LotEvent {
  const DeletelotEvent({required this.lotID, required this.productID});

  final int lotID;
  final int productID;
  @override
  List<Object> get props => [];
}
