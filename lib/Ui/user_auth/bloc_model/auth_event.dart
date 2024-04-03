abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String userEmail;
  final String password;
  LoginEvent({required this.userEmail, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String userEmail;
  final String password;
  RegisterEvent({required this.userEmail, required this.password});
}

class LogOutEvent extends AuthEvent{}
