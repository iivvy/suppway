part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class GetSession extends AuthenticationEvent {}

class Authenticate extends AuthenticationEvent {
  const Authenticate({required this.userName, required this.userPassword});
  final String userName;
  final String userPassword;
  @override
  List<Object> get props => [];
}

class LogOut extends AuthenticationEvent {}
