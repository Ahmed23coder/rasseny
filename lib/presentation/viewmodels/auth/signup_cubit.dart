import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_picker/country_picker.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _repository;

  SignupCubit(this._repository) : super(const SignupState());

  void updateFullName(String val) {
    emit(state.copyWith(
      fullName: val,
      fullNameError: val.isEmpty ? "Name cannot be empty" : null,
      status: SignupStatus.initial,
    ));
  }

  void updateEmail(String val) {
    String? error;
    if (val.isNotEmpty) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(val)) {
        error = "Please enter a valid email address";
      }
    }
    emit(state.copyWith(
      email: val,
      emailError: error,
      status: SignupStatus.initial,
    ));
  }

  void updatePhone(String val) {
    emit(state.copyWith(
      phone: val,
      phoneError: val.isEmpty ? "Phone number is required" : null,
      status: SignupStatus.initial,
    ));
  }

  void updateCountry(Country val) {
    emit(state.copyWith(
      country: val,
      countryError: null,
      status: SignupStatus.initial,
    ));
  }

  void updateGender(String val) {
    emit(state.copyWith(
      gender: val,
      genderError: null,
      status: SignupStatus.initial,
    ));
  }

  void updatePassword(String val) {
    String? error;
    if (val.isNotEmpty && val.length < 6) {
      error = "Password must be at least 6 characters";
    }
    emit(state.copyWith(
      password: val,
      passwordError: error,
      passwordStrength: _calculateStrength(val),
      status: SignupStatus.initial,
    ));
  }

  int _calculateStrength(String password) {
    if (password.length < 6) return 0;
    if (password.length < 10) return 1;
    if (RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(password)) return 3;
    return 2;
  }

  void updateConfirmPassword(String val) {
    emit(state.copyWith(
      confirmPassword: val,
      confirmPasswordError: val != state.password ? "Passwords do not match" : null,
      status: SignupStatus.initial,
    ));
  }

  void togglePasswordVisibility() => emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));

  Future<void> submit() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(status: SignupStatus.loading));

    try {
      await _repository.signUp({
        'fullName': state.fullName,
        'email': state.email,
        'phone': state.phone,
        'country': state.country?.name,
        'gender': state.gender,
        'password': state.password,
      });
      emit(state.copyWith(status: SignupStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: SignupStatus.error,
        errorMessage: e.toString().replaceAll("Exception: ", ""),
      ));
    }
  }
}
