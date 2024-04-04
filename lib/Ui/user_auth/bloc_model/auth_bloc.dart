import 'package:connectivity_plus/connectivity_plus.dart';
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
    on<SetAuthPin>(setAuthPin);
    on<SeVerifyAuthPin>(verifyAuthPin);
  }

  Future<void> loginUser(LoginEvent event, Emitter<AuthState> emit) async {
    if (!await _isConnected()) {
     emit(FailedState(errorMessage: 'No internet connection'));
     return;
    }
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
    if (!await _isConnected()) {
      emit(FailedState(errorMessage: 'No internet connection'));
      return;
    }
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
    if (!await _isConnected()) {
      emit(FailedState(errorMessage: 'No internet connection'));
      return;
    }
    emit(LoadingState());
    try {
      var result = await _userAuthModel.logOut();
      if (result) {
        emit(InitialSate());
      } else {
        emit(FailedState(errorMessage: "logOut failed"));
      }
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }

  Future<void> setAuthPin(SetAuthPin event, Emitter<AuthState> emit) async {
    if (!await _isConnected()) {
      emit(FailedState(errorMessage: 'No internet connection'));
      return;
    }
    emit(LoadingState());
    try {
      final userPin = event.userAuthPin;
      var result = await _userAuthModel.setAuthPin(userPin);
      if (result) {
        emit(AuthPinSuccessSate(successStatus: 'Pin Successfully Saved'));
      } else {
        emit(FailedState(errorMessage: "Pin set Failed"));
      }
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }

  Future<void> verifyAuthPin(
      SeVerifyAuthPin event, Emitter<AuthState> emit) async {
    if (!await _isConnected()) {
      emit(FailedState(errorMessage: 'No internet connection'));
      return;
    }
    emit(LoadingState());
    try {
      final userPin = event.verifyAuthPin;
      var result = await _userAuthModel.verifyPin(userPin);
      if (result) {
        emit(AuthPinSuccessSate(successStatus: 'Successfully Verify'));
      } else {
        emit(FailedState(errorMessage: "InvalidPin"));
      }
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }
  Future<bool> _isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }


}
