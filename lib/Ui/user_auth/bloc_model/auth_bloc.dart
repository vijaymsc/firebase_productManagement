import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/auth_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserAuthModel _userAuthModel = UserAuthModel();
  AuthBloc() : super(InitialSate()) {
    on<LoginEvent>(loginUser);
    on<RegisterEvent>(registerUser);
    on<LogOutEvent>(logoutUser);
  }

  Future<void> loginUser(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try {
      final userEmail = event.userEmail;
      final password = event.password;
      var result = await _userAuthModel.loginUser(userEmail, password);
      emit(SuccessSate(user: result!));
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
      emit(InitialSate());
    }
  }

  Future<void> registerUser(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try {
      final userEmail = event.userEmail;
      final password = event.password;
      var result = await _userAuthModel.createUser(userEmail, password);
      emit(SuccessSate(user: result!));
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
      emit(InitialSate());
    }
  }

  Future<void> logoutUser(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try {
      var result = await _userAuthModel.logOut();
      if (result) {
        emit(InitialSate());
      } else {
        emit(FailedState(errorMessage: "logOut failled"));
      }
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }
}
