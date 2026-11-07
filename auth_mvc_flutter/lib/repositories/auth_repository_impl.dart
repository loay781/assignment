import '../models/auth_models.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  UserModel? _user = const UserModel(
    fullName: 'طالب تجريبي',
    academicId: '123456789',
    universityEmail: 'student@university.edu',
    password: 'Student1',
  );
  String? _lastResetIdentifier;
  final String _demoOtp = '123456';

  Future<void> _simulateNetwork() async {
    await Future<void>.delayed(const Duration(milliseconds: 850));
  }

  @override
  Future<void> login(LoginRequest request) async {
    await _simulateNetwork();
    final user = _user;
    if (user == null ||
        (request.identifier != user.academicId &&
            request.identifier.toLowerCase() != user.universityEmail.toLowerCase()) ||
        request.password != user.password) {
      throw Exception('المعرف أو كلمة المرور غير صحيحة');
    }
  }

  @override
  Future<void> register(RegisterRequest request) async {
    await _simulateNetwork();
    _user = UserModel(
      fullName: request.fullName,
      academicId: request.academicId,
      universityEmail: request.universityEmail,
      password: request.password,
    );
  }

  @override
  Future<void> sendPasswordResetCode(String identifier) async {
    await _simulateNetwork();
    final user = _user;
    if (user == null ||
        (identifier != user.academicId &&
            identifier.toLowerCase() != user.universityEmail.toLowerCase())) {
      throw Exception('لم يتم العثور على حساب بهذا البريد أو الرقم الأكاديمي');
    }
    _lastResetIdentifier = identifier;
  }

  @override
  Future<void> resetPassword(PasswordResetRequest request) async {
    await _simulateNetwork();
    if (request.otp != _demoOtp || request.identifier != _lastResetIdentifier) {
      throw Exception('رمز التحقق غير صحيح');
    }
    final user = _user;
    if (user == null) throw Exception('الحساب غير موجود');
    _user = UserModel(
      fullName: user.fullName,
      academicId: user.academicId,
      universityEmail: user.universityEmail,
      password: request.newPassword,
    );
  }
}
