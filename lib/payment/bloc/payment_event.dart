part of 'payment_bloc.dart';

class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentAuthorize extends PaymentEvent {}

class PaymentDeAuthorize extends PaymentEvent {}

class PaymentReturn extends PaymentEvent {
  const PaymentReturn({required this.url});
  final String url;
}

class GetPaymentList extends PaymentEvent {
  const GetPaymentList({required this.limitListPayment});
  final int limitListPayment;
}
