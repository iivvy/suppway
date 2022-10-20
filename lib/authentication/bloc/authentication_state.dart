part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial({this.userName, this.userPassword});
  final String? userName;
  final String? userPassword;
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError({required this.error});
  final String error;
}

class Authenticated extends AuthenticationState {}
