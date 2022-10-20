part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class PatchProfileEvent extends ProfileEvent {
  const PatchProfileEvent({required this.value});
  final Map value;
}

class PostPartnerAvatarEvent extends ProfileEvent {
  const PostPartnerAvatarEvent({required this.avatar});
  final XFile? avatar;
}
