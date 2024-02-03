abstract class RegisterState {}

class RegisterInitState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterResponseState extends RegisterState {
  String response;
  RegisterResponseState(this.response);
}

class RegisterErrorState extends RegisterState {
  String error;

  RegisterErrorState(this.error);
}
