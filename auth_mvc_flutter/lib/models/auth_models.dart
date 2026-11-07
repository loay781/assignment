class UserModel {
  final String fullName;
  final String academicId;
  final String universityEmail;
  final String password;

  const UserModel({
    required this.fullName,
    required this.academicId,
    required this.universityEmail,
    required this.password,
  });
}

class LoginRequest {
  final String identifier;
  final String password;
  final bool rememberMe;

  const LoginRequest({
    required this.identifier,
    required this.password,
    required this.rememberMe,
  });
}

class RegisterRequest {
  final String fullName;
  final String academicId;
  final String universityEmail;
  final String password;

  const RegisterRequest({
    required this.fullName,
    required this.academicId,
    required this.universityEmail,
    required this.password,
  });
}

class PasswordResetRequest {
  final String identifier;
  final String otp;
  final String newPassword;

  const PasswordResetRequest({
    required this.identifier,
    required this.otp,
    required this.newPassword,
  });
}
