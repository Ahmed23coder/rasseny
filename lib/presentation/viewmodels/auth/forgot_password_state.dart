import 'package:equatable/equatable.dart';

enum ForgotPasswordStatus { initial, loading, success, error }

class ForgotPasswordState extends Equatable {
  final String email;
  final String? emailError;
  final ForgotPasswordStatus status;
  final String? errorMessage;

  const ForgotPasswordState({
    this.email = '',
    this.emailError,
    this.status = ForgotPasswordStatus.initial,
    this.errorMessage,
  });

  bool get isFormValid =>
      email.isNotEmpty && email.contains('@') && emailError == null;

  static const Object _sentinel = Object();

  ForgotPasswordState copyWith({
    String? email,
    Object? emailError = _sentinel,
    ForgotPasswordStatus? status,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      emailError: emailError == _sentinel ? this.emailError : (emailError as String?),
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, emailError, status, errorMessage];
}
