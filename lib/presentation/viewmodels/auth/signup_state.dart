import 'package:equatable/equatable.dart';
import 'package:country_picker/country_picker.dart';

enum SignupStatus { initial, loading, success, error }

class SignupState extends Equatable {
  final String fullName;
  final String email;
  final String phone;
  final Country? country;
  final String? gender;
  final String password;
  final String confirmPassword;
  final int passwordStrength; // 0-3
  
  // New Error Fields
  final String? fullNameError;
  final String? emailError;
  final String? phoneError;
  final String? countryError;
  final String? genderError;
  final String? passwordError;
  final String? confirmPasswordError;

  final bool isPasswordVisible;
  final SignupStatus status;
  final String? errorMessage;

  const SignupState({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.country,
    this.gender,
    this.password = '',
    this.confirmPassword = '',
    this.passwordStrength = 0,
    this.fullNameError,
    this.emailError,
    this.phoneError,
    this.countryError,
    this.genderError,
    this.passwordError,
    this.confirmPasswordError,
    this.isPasswordVisible = false,
    this.status = SignupStatus.initial,
    this.errorMessage,
  });

  bool get isFormValid =>
      fullName.isNotEmpty &&
      email.isNotEmpty &&
      email.contains('@') &&
      phone.isNotEmpty &&
      country != null &&
      gender != null &&
      password.length >= 6 &&
      confirmPassword == password &&
      fullNameError == null &&
      emailError == null &&
      phoneError == null &&
      passwordError == null &&
      confirmPasswordError == null;

  static const Object _sentinel = Object();

  SignupState copyWith({
    String? fullName,
    String? email,
    String? phone,
    Country? country,
    String? gender,
    String? password,
    String? confirmPassword,
    int? passwordStrength,
    Object? fullNameError = _sentinel,
    Object? emailError = _sentinel,
    Object? phoneError = _sentinel,
    Object? countryError = _sentinel,
    Object? genderError = _sentinel,
    Object? passwordError = _sentinel,
    Object? confirmPasswordError = _sentinel,
    bool? isPasswordVisible,
    SignupStatus? status,
    String? errorMessage,
  }) {
    return SignupState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      passwordStrength: passwordStrength ?? this.passwordStrength,
      fullNameError: fullNameError == _sentinel ? this.fullNameError : (fullNameError as String?),
      emailError: emailError == _sentinel ? this.emailError : (emailError as String?),
      phoneError: phoneError == _sentinel ? this.phoneError : (phoneError as String?),
      countryError: countryError == _sentinel ? this.countryError : (countryError as String?),
      genderError: genderError == _sentinel ? this.genderError : (genderError as String?),
      passwordError: passwordError == _sentinel ? this.passwordError : (passwordError as String?),
      confirmPasswordError: confirmPasswordError == _sentinel ? this.confirmPasswordError : (confirmPasswordError as String?),
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        phone,
        country,
        gender,
        password,
        confirmPassword,
        passwordStrength,
        fullNameError,
        emailError,
        phoneError,
        countryError,
        genderError,
        passwordError,
        confirmPasswordError,
        isPasswordVisible,
        status,
        errorMessage,
      ];
}
