part of 'lot_bloc.dart';

abstract class LotState extends Equatable {
  const LotState();

  @override
  List<Object> get props => [];
}

class LotsInitialState extends LotState {}

class LotsLoading extends LotState {}

class LotsLoaded extends LotState {
  const LotsLoaded({required this.lots});
  final List<Lot> lots;
  @override
  List<Object> get props => [lots];
}

class LotsLoadingError extends LotState {
  const LotsLoadingError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class LotCreated extends LotState {}

class LotCreationFailed extends LotState {
  const LotCreationFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class LotUpdated extends LotState {}

class LotUpdatedFailed extends LotState {
  const LotUpdatedFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class LotDeleted extends LotState {}

class LotDeletedFailed extends LotState {
  const LotDeletedFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
