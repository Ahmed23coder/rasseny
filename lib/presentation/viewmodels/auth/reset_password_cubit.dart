import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetState> {
  final AuthRepository _repository;

  ResetPasswordCubit(this._repository) : super(const ResetState());

  void updateNewPassword(String password) {
    String? error;
    if (password.isNotEmpty && password.length < 6) {
      error = "Password must be at least 6 characters";
    }
    emit(state.copyWith(
      newPassword: password,
      newPasswordError: error,
      passwordStrength: _calculateStrength(password),
      status: ResetStatus.initial,
    ));
  }

  void updateConfirmPassword(String password) {
    emit(state.copyWith(
      confirmPassword: password,
      confirmPasswordError: password != state.newPassword ? "Passwords do not match" : null,
      status: ResetStatus.initial,
    ));
  }

  void toggleNewPasswordVisibility() {
    emit(state.copyWith(isNewPasswordVisible: !state.isNewPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  int _calculateStrength(String password) {
    if (password.length < 6) return 0;
    if (password.length < 10) return 1;
    if (RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(password)) return 3;
    return 2;
  }

  Future<void> submit() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(status: ResetStatus.loading));

    try {
      await _repository.resetPassword(state.newPassword);
      emit(state.copyWith(status: ResetStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: ResetStatus.error,
        errorMessage: e.toString().replaceAll("Exception: ", ""),
      ));
    }
  }
}
