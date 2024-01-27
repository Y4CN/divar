import 'package:divar_app/pages/dep_injection.dart';
import 'package:divar_app/pages/login/bloc/login_event.dart';
import 'package:divar_app/pages/login/bloc/login_state.dart';
import 'package:divar_app/pages/login/controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ILoginController _controllerLogin = locator.get<ILoginController>();

  LoginBloc() : super(LoginInitState()) {
    on<LoginRequest>((event, emit) async {
      emit(LoginLoadingState());

      var response = await _controllerLogin.login(event.email, event.pass);

      response.fold((l) {
        emit(LoginErrorState(l));
      }, (r) {
        emit(LoginResponseState(r));
      });
    });
  }
}
