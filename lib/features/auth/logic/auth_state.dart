/// All possible states for the authentication flow.
abstract class AuthState {
  const AuthState();
}

/// Initial state – show Login screen.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Generic loading overlay.
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Login screen state.
class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// Sign-Up screen state.
class Registering extends AuthState {
  const Registering();
}

/// OTP Verification screen state.
class OTPVerification extends AuthState {
  const OTPVerification({
    this.remainingSeconds = 60,
    this.email = '',
  });

  final int remainingSeconds;
  final String email;
}

/// Forgot Password screen state.
class ForgotPasswordState extends AuthState {
  const ForgotPasswordState();
}

/// Reset Password screen state.
class ResetPasswordState extends AuthState {
  const ResetPasswordState({this.email = ''});

  final String email;
}

/// Authentication success screen.
class AuthSuccess extends AuthState {
  const AuthSuccess();
}

/// Form-level error (keeps current screen, shows inline errors).
class AuthError extends AuthState {
  const AuthError({required this.message, required this.previousState});

  final String message;
  final AuthState previousState;
}
