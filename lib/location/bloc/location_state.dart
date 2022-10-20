part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitialState extends LocationState {}

class LocationsLoading extends LocationState {}

class LocationsLoaded extends LocationState {
  const LocationsLoaded({required this.locationsListModel});
  final LocationListModel locationsListModel;
  @override
  List<Object> get props => [locationsListModel];
}

class LocationCreated extends LocationState {}

class LocationCreationFailed extends LocationState {
  const LocationCreationFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class DeleteLocationSuccess extends LocationState {}

class DeleteLocationError extends LocationState {
  const DeleteLocationError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class LocationUpdated extends LocationState {}

class LocationUpdateError extends LocationState {
  const LocationUpdateError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
