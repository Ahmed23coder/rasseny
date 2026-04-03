import '../../domain/repositories/auth_repository.dart';

/// PROTOTYPE: This shows how the existing [AuthRepository] interface
/// is implemented when connecting to a real production database/API.
class RemoteAuthRepository implements AuthRepository {
  @override
  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'error@test.com') {
      throw Exception("User not found or invalid credentials");
    }
  }

  @override
  Future<void> signUp(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 2));
    if (data['email'] == 'error@test.com') {
      throw Exception("Email already in use");
    }
  }

  @override
  Future<void> sendOtp(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> verifyOtp(String code) async {
    await Future.delayed(const Duration(seconds: 1));
    if (code == '000000') throw Exception("Invalid verification code");
  }

  @override
  Future<void> resendOtp() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> resetPassword(String newPassword) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
