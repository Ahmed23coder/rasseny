import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

/// Manages the authentication flow across all auth screens.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const Unauthenticated());

  Timer? _otpTimer;

  // ── Navigation ──

  void showLogin() => emit(const Unauthenticated());

  void showSignUp() => emit(const Registering());

  void showForgotPassword() => emit(const ForgotPasswordState());

  void showResetPassword({String email = ''}) =>
      emit(ResetPasswordState(email: email));

  // ── Login ──

  Future<void> submitLogin({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || !email.contains('@')) {
      emit(const AuthError(
        message: 'Invalid email format',
        previousState: Unauthenticated(),
      ));
      return;
    }
    if (password.length < 6) {
      emit(const AuthError(
        message: 'Password must be at least 6 characters',
        previousState: Unauthenticated(),
      ));
      return;
    }

    emit(const AuthSuccess());
  }

  // ── Sign Up ──

  Future<void> submitRegistration({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(seconds: 1));

    if (fullName.isEmpty) {
      emit(const AuthError(
        message: 'Full name is required',
        previousState: Registering(),
      ));
      return;
    }
    if (email.isEmpty || !email.contains('@')) {
      emit(const AuthError(
        message: 'Invalid email format',
        previousState: Registering(),
      ));
      return;
    }
    if (password.length < 6) {
      emit(const AuthError(
        message: 'Password must be at least 6 characters',
        previousState: Registering(),
      ));
      return;
    }

    // Navigate to OTP verification
    _startOtpTimer(email);
  }

  // ── OTP ──

  void _startOtpTimer(String email) {
    _otpTimer?.cancel();
    emit(OTPVerification(remainingSeconds: 60, email: email));

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = state;
      if (current is OTPVerification && current.remainingSeconds > 0) {
        emit(OTPVerification(
          remainingSeconds: current.remainingSeconds - 1,
          email: current.email,
        ));
      } else {
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    final current = state;
    if (current is OTPVerification) {
      _startOtpTimer(current.email);
    }
  }

  Future<void> submitOtp(String otp) async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(milliseconds: 800));
    _otpTimer?.cancel();
    emit(const AuthSuccess());
  }

  // ── Forgot Password ──

  Future<void> submitForgotPassword({required String email}) async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || !email.contains('@')) {
      emit(const AuthError(
        message: 'Please enter a valid email',
        previousState: ForgotPasswordState(),
      ));
      return;
    }

    // Navigate to OTP for reset flow
    _startOtpTimer(email);
  }

  // ── Reset Password ──

  Future<void> submitResetPassword({
    required String password,
    required String confirmPassword,
  }) async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(seconds: 1));

    if (password.length < 6) {
      emit(const AuthError(
        message: 'Password must be at least 6 characters',
        previousState: ResetPasswordState(),
      ));
      return;
    }
    if (password != confirmPassword) {
      emit(const AuthError(
        message: 'Passwords do not match',
        previousState: ResetPasswordState(),
      ));
      return;
    }

    emit(const AuthSuccess());
  }

  @override
  Future<void> close() {
    _otpTimer?.cancel();
    return super.close();
  }
}
