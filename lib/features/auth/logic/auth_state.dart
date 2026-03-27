import 'package:supabase_flutter/supabase_flutter.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  final AuthState previousState;
  const AuthLoading(this.previousState);
}

class Authenticated extends AuthState {
  final User user;
  const Authenticated(this.user);
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthFailure extends AuthState {
  final String message;
  final AuthState previousState;
  const AuthFailure(this.message, this.previousState);
}

// ── Flow Specific States ──

class Registering extends AuthState {
  const Registering();
}

class OTPVerification extends AuthState {
  final String email;
  final int remainingSeconds;
  final bool isForgotFlow;
  const OTPVerification({
    required this.email,
    this.remainingSeconds = 60,
    this.isForgotFlow = false,
  });
}

class ForgotPasswordState extends AuthState {
  const ForgotPasswordState();
}

class ResetPasswordState extends AuthState {
  final String email;
  const ResetPasswordState({this.email = ''});
}

class AuthSuccess extends AuthState {
  const AuthSuccess();
}

class AuthOnboarding extends AuthState {
  const AuthOnboarding();
}
