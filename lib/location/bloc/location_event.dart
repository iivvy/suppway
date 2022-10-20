part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetLocationsEvent extends LocationEvent {}

class GetLocationByPosition extends LocationEvent {
  const GetLocationByPosition({required this.position});
  final LatLng position;
}

class AddLocation extends LocationEvent {
  const AddLocation({required this.location});

  final Location location;
}

class DeleteLocation extends LocationEvent {
  const DeleteLocation({required this.locationId});
  final int locationId;
  @override
  List<Object> get props => [];
}

class PatchLocation extends LocationEvent {
  const PatchLocation(
      {required this.locationId, required this.updatedLocationData});
  final int locationId;
  final Map updatedLocationData;
  @override
  List<Object> get props => [];
}
