import 'package:flutter/foundation.dart';
import '../models/auth_models.dart';
import '../repositories/auth_repository.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository repository;
  bool isLoading = false;
  String? errorMessage;

  AuthController({required this.repository});

  Future<bool> login(LoginRequest request) async {
    return _run(() => repository.login(request));
  }

  Future<bool> register(RegisterRequest request) async {
    return _run(() => repository.register(request));
  }

  Future<bool> sendPasswordResetCode(String identifier) async {
    return _run(() => repository.sendPasswordResetCode(identifier));
  }

  Future<bool> resetPassword(PasswordResetRequest request) async {
    return _run(() => repository.resetPassword(request));
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  Future<bool> _run(Future<void> Function() action) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      await action();
      return true;
    } catch (error) {
      errorMessage = error.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
