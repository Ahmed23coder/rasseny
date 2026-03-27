import 'package:supabase_flutter/supabase_flutter.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;
  const LoginSubmitted(this.email, this.password);
}

class SignUpSubmitted extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  const SignUpSubmitted({
    required this.email,
    required this.password,
    required this.fullName,
  });
}

class VerifyOTPSubmitted extends AuthEvent {
  final String email;
  final String token;
  const VerifyOTPSubmitted(this.email, this.token);
}

class SocialSignInPressed extends AuthEvent {
  final OAuthProvider provider;
  const SocialSignInPressed(this.provider);
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;
  const ForgotPasswordRequested({required this.email});
}

class ResetPasswordSubmitted extends AuthEvent {
  final String password;
  const ResetPasswordSubmitted({required this.password});
}

class ShowLoginEvent extends AuthEvent {
  const ShowLoginEvent();
}

class ShowSignUpEvent extends AuthEvent {
  const ShowSignUpEvent();
}

class ShowForgotPasswordEvent extends AuthEvent {
  const ShowForgotPasswordEvent();
}

class ShowResetPasswordEvent extends AuthEvent {
  final String email;
  const ShowResetPasswordEvent(this.email);
}

class OtpTick extends AuthEvent {
  final int remainingSeconds;
  const OtpTick(this.remainingSeconds);
}

class SuccessGetStartedPressed extends AuthEvent {
  const SuccessGetStartedPressed();
}

class AuthGoBack extends AuthEvent {
  const AuthGoBack();
}

class ResendOtpRequested extends AuthEvent {
  final String email;
  const ResendOtpRequested(this.email);
}
