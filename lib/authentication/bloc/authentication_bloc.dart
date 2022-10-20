import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authenticate_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService;
  AuthenticationBloc({required this.authenticationService})
      : super(const AuthenticationInitial(userName: "", userPassword: "")) {
    on<GetSession>((event, emit) async {
      emit(AuthenticationLoading());
      await authenticationService.getSession();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userName = prefs.getString('email');
      String? userPassword = prefs.getString('password');

      emit(AuthenticationInitial(
          userName: userName, userPassword: userPassword));
    });

    on<Authenticate>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final bool response = await authenticationService.userAuthentication(
            event.userName, event.userPassword);
        if (response) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', event.userName);
          prefs.setString('password', event.userPassword);
          emit(Authenticated());
        } else {
          emit(AuthenticationError(error: "Authentication error"));
        }
      } catch (e) {
        emit(AuthenticationError(error: e.toString()));
      }
    });
    on<LogOut>((event, emit) async {
      emit(AuthenticationLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
      prefs.remove('password');
      emit(const AuthenticationInitial(userName: null, userPassword: null));
    });
  }
}
