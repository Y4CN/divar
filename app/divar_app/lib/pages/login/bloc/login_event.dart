abstract class LoginEvent {}

class LoginRequest extends LoginEvent {

  String email;
  String pass;

  LoginRequest({
  
    required this.email,
    required this.pass,
  });
}
