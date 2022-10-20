part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({required this.partner});
  final Partner partner;
  @override
  List<Object> get props => [partner];
}

class ProfileLoadError extends ProfileState {
  const ProfileLoadError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class ProfileUpdated extends ProfileState {}

class ProfileUpdateFailed extends ProfileState {
  const ProfileUpdateFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
