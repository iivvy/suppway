part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoding extends PaymentState {}

class AuthorizeSuccess extends PaymentState {
  const AuthorizeSuccess({required this.uri});
  final String uri;
}

class PaymentError extends PaymentState {
  const PaymentError({required this.error});
  final String error;
}

class AuthorizeRetrunSuccess extends PaymentState {}

class DeAuthorizeSuccess extends PaymentState {}

class PaymentListloaded extends PaymentState {
  const PaymentListloaded({required this.paymentList});
  final List<Payment> paymentList;
}
