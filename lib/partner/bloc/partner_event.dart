part of 'partner_bloc.dart';

abstract class PartnerEvent extends Equatable {
  const PartnerEvent();

  @override
  List<Object> get props => [];
}

class GetPartnersEvent extends PartnerEvent {}

class PatchPartner extends PartnerEvent {
  const PatchPartner(
      {required this.partnerId, required this.updatedPartnerData});
  final int partnerId;
  final Map updatedPartnerData;
  @override
  List<Object> get props => [];
}

class AddPartnerEvent extends PartnerEvent {
  const AddPartnerEvent({required this.partnerData});

  final Partner partnerData;

  @override
  List<Object> get props => [];
}

class DeletePartner extends PartnerEvent {
  const DeletePartner({required this.partnerId});
  final int partnerId;
  @override
  List<Object> get props => [];
}

class PostPartnerAvatarEvent extends PartnerEvent {
  const PostPartnerAvatarEvent({required this.avatar, required this.partnerId});
  final XFile? avatar;
  final int partnerId;
}
