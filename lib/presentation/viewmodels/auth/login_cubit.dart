import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _repository;

  LoginCubit(this._repository) : super(const LoginState());

  void updateEmail(String email) {
    String? error;
    if (email.isNotEmpty) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        error = "Please enter a valid email address";
      }
    }
    emit(state.copyWith(
      email: email,
      emailError: error,
      status: LoginStatus.initial,
    ));
  }

  void updatePassword(String password) {
    String? error;
    if (password.isNotEmpty && password.length < 6) {
      error = "Password must be at least 6 characters";
    }
    emit(state.copyWith(
      password: password,
      passwordError: error,
      status: LoginStatus.initial,
    ));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> submit() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      await _repository.login(state.email, state.password);
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.error,
        errorMessage: e.toString().replaceAll("Exception: ", ""),
      ));
    }
  }
}
