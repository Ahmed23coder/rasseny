abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> signUp(Map<String, dynamic> data);
  Future<void> sendOtp(String email);
  Future<void> verifyOtp(String code);
  Future<void> resendOtp();
  Future<void> resetPassword(String newPassword);
}
