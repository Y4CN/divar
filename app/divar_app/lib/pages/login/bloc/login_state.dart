abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  String response;
  LoginErrorState(this.response);
}

class LoginResponseState extends LoginState {
  String response;
  LoginResponseState(this.response);
}
