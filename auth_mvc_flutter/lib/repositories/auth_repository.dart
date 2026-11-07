import '../models/auth_models.dart';

abstract class AuthRepository {
  Future<void> login(LoginRequest request);
  Future<void> register(RegisterRequest request);
  Future<void> sendPasswordResetCode(String identifier);
  Future<void> resetPassword(PasswordResetRequest request);
}
