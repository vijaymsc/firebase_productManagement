import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class InitialSate extends AuthState {}

class SuccessSate extends AuthState {
  final User user;
  SuccessSate({required this.user});
}

class FailedState extends AuthState {
  final String errorMessage;
  FailedState({required this.errorMessage});
}

class AuthPinSuccessSate extends AuthState {
  String successStatus;
  AuthPinSuccessSate({required this.successStatus});
}

class LoadingState extends AuthState {}
