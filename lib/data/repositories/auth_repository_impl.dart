import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == "error@test.com") {
      throw Exception("Invalid email or password");
    }
  }

  @override
  Future<void> signUp(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 1));
    if (data['email'] == "error@test.com") {
      throw Exception("Email already registered");
    }
  }

  @override
  Future<void> sendOtp(String email) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (email == "error@test.com") {
      throw Exception("Could not send code");
    }
  }

  @override
  Future<void> verifyOtp(String code) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (code == "000000") {
      throw Exception("Invalid verification code");
    }
  }

  @override
  Future<void> resendOtp() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> resetPassword(String newPassword) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
