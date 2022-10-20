import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:suppwayy_mobile/payment/model/payment_list_model.dart';
import 'package:suppwayy_mobile/payment/payment_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentService paymentService;

  PaymentBloc({required this.paymentService}) : super(PaymentInitial()) {
    on<PaymentAuthorize>((event, emit) async {
      emit(PaymentLoding());
      try {
        var response = await paymentService.authorize();
        emit(AuthorizeSuccess(uri: response));
      } catch (e) {
        emit(PaymentError(error: e.toString()));
      }
    });
    on<PaymentReturn>((event, emit) async {
      emit(PaymentLoding());
      try {
        var response = await paymentService.handleRetrun(event.url);
        if (response) {
          emit(AuthorizeRetrunSuccess());
        }
      } catch (e) {
        emit(PaymentError(error: e.toString()));
        rethrow;
      }
    });
    on<PaymentDeAuthorize>((event, emit) async {
      emit(PaymentLoding());
      try {
        var response = await paymentService.deAuthorize();
        if (response) {
          emit(DeAuthorizeSuccess());
        }
      } catch (e) {
        emit(PaymentError(error: e.toString()));
      }
    });
    on<GetPaymentList>((event, emit) async {
      emit(PaymentLoding());
      try {
        List<Payment> paymentList =
            await paymentService.getPaymentsList(event.limitListPayment);
        emit(PaymentListloaded(paymentList: paymentList));
      } catch (e) {
        emit(PaymentError(error: e.toString()));
      }
    });
  }
}
