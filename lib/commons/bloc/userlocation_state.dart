part of 'userlocation_bloc.dart';

abstract class UserlocationState extends Equatable {
  const UserlocationState();

  @override
  List<Object> get props => [];
}

class UserlocationInitial extends UserlocationState {}

class UserLocationPermissionRefuse extends UserlocationState {}

class UserLocationLoaded extends UserlocationState {
  const UserLocationLoaded({required this.position});
  final LatLng position;
  @override
  List<LatLng> get props => [position];
}
