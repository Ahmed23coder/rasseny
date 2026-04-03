import 'package:equatable/equatable.dart';

enum ResetStatus { initial, loading, success, error }

class ResetState extends Equatable {
  final String newPassword;
  final String confirmPassword;
  final String? newPasswordError;
  final String? confirmPasswordError;
  final int passwordStrength; // 0-3
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;
  final ResetStatus status;
  final String? errorMessage;

  const ResetState({
    this.newPassword = '',
    this.confirmPassword = '',
    this.newPasswordError,
    this.confirmPasswordError,
    this.passwordStrength = 0,
    this.isNewPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.status = ResetStatus.initial,
    this.errorMessage,
  });

  bool get isFormValid =>
      newPassword.length >= 6 &&
      confirmPassword == newPassword &&
      newPasswordError == null &&
      confirmPasswordError == null;

  static const Object _sentinel = Object();

  ResetState copyWith({
    String? newPassword,
    String? confirmPassword,
    Object? newPasswordError = _sentinel,
    Object? confirmPasswordError = _sentinel,
    int? passwordStrength,
    bool? isNewPasswordVisible,
    bool? isConfirmPasswordVisible,
    ResetStatus? status,
    String? errorMessage,
  }) {
    return ResetState(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      newPasswordError: newPasswordError == _sentinel ? this.newPasswordError : (newPasswordError as String?),
      confirmPasswordError: confirmPasswordError == _sentinel ? this.confirmPasswordError : (confirmPasswordError as String?),
      passwordStrength: passwordStrength ?? this.passwordStrength,
      isNewPasswordVisible: isNewPasswordVisible ?? this.isNewPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        newPassword,
        confirmPassword,
        newPasswordError,
        confirmPasswordError,
        passwordStrength,
        isNewPasswordVisible,
        isConfirmPasswordVisible,
        status,
        errorMessage,
      ];
}
