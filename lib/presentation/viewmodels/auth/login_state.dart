import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isPasswordVisible;
  final LoginStatus status;
  final String? errorMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isPasswordVisible = false,
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  bool get isFormValid =>
      email.isNotEmpty &&
      email.contains('@') &&
      password.length >= 6 &&
      emailError == null &&
      passwordError == null;

  static const Object _sentinel = Object();

  LoginState copyWith({
    String? email,
    String? password,
    Object? emailError = _sentinel,
    Object? passwordError = _sentinel,
    bool? isPasswordVisible,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError == _sentinel ? this.emailError : (emailError as String?),
      passwordError: passwordError == _sentinel ? this.passwordError : (passwordError as String?),
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        emailError,
        passwordError,
        isPasswordVisible,
        status,
        errorMessage,
      ];
}
