part of 'partner_bloc.dart';

abstract class PartnerState extends Equatable {
  const PartnerState();

  @override
  List<Object> get props => [];
}

class PartnersInitialState extends PartnerState {}

class PartnersLoading extends PartnerState {}

class PartnersLoaded extends PartnerState {
  const PartnersLoaded({required this.partners});
  final List<Partner> partners;
  @override
  List<Object> get props => [partners];
}

class PartnersLoadingError extends PartnerState {
  const PartnersLoadingError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class PartnerCreated extends PartnerState {}

class PartnerCreationFailed extends PartnerState {
  const PartnerCreationFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class PatchPartnerSuccess extends PartnerState {}

class PatchPartnerError extends PartnerState {
  const PatchPartnerError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class DeletePartnerSuccess extends PartnerState {}

class DeletePartnerError extends PartnerState {
  const DeletePartnerError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
