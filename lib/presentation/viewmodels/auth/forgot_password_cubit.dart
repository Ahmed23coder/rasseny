import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _repository;

  ForgotPasswordCubit(this._repository) : super(const ForgotPasswordState());

  void updateEmail(String email) {
    String? error;
    if (email.isNotEmpty && !email.contains('@')) {
      error = "Enter a valid email address";
    }
    emit(state.copyWith(
      email: email,
      emailError: error,
      status: ForgotPasswordStatus.initial,
    ));
  }

  Future<void> sendCode() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(status: ForgotPasswordStatus.loading));

    try {
      await _repository.sendOtp(state.email);
      emit(state.copyWith(status: ForgotPasswordStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.error,
        errorMessage: e.toString().replaceAll("Exception: ", ""),
      ));
    }
  }
}
