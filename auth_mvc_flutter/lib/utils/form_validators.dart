class FormValidators {
  static String? requiredText(String? value, {String field = 'هذا الحقل'}) {
    if (value == null || value.trim().isEmpty) return 'يرجى إدخال $field';
    return null;
  }

  static String? loginIdentifier(String? value) {
    final required = requiredText(value, field: 'المعرف الأكاديمي أو البريد');
    if (required != null) return required;
    if (value!.trim().length < 5) return 'يجب ألا يقل المعرف عن 5 خانات';
    return null;
  }

  static String? password(String? value) {
    final required = requiredText(value, field: 'كلمة المرور');
    if (required != null) return required;
    if (value!.length < 6) return 'يجب ألا تقل كلمة المرور عن 6 محارف';
    return null;
  }

  static String? strongPassword(String? value) {
    final required = requiredText(value, field: 'كلمة المرور');
    if (required != null) return required;
    if (value!.length < 8) return 'يجب ألا تقل كلمة المرور عن 8 محارف';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'يجب أن تحتوي على رقم واحد على الأقل';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'يجب أن تحتوي على حرف كبير واحد على الأقل';
    return null;
  }

  static String? fullName(String? value) {
    final required = requiredText(value, field: 'الاسم الكامل');
    if (required != null) return required;
    if (value!.trim().length < 3) return 'يجب ألا يقل الاسم عن 3 محارف';
    return null;
  }

  static String? academicId(String? value) {
    final required = requiredText(value, field: 'الرقم الأكاديمي');
    if (required != null) return required;
    if (!RegExp(r'^\d{9,10}$').hasMatch(value!.trim())) {
      return 'الرقم الأكاديمي أرقام فقط من 9 إلى 10 خانات';
    }
    return null;
  }

  static String? universityEmail(String? value) {
    final required = requiredText(value, field: 'البريد الجامعي');
    if (required != null) return required;
    final email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!email.hasMatch(value!.trim())) return 'أدخل بريدًا إلكترونيًا صحيحًا';
    return null;
  }

  static String? confirmation(String? value, String original) {
    final required = requiredText(value, field: 'تأكيد كلمة المرور');
    if (required != null) return required;
    if (value != original) return 'كلمتا المرور غير متطابقتين';
    return null;
  }

  static String? otp(String? value) {
    final required = requiredText(value, field: 'رمز التحقق');
    if (required != null) return required;
    if (!RegExp(r'^\d{6}$').hasMatch(value!.trim())) return 'الرمز يجب أن يتكون من 6 أرقام';
    return null;
  }
}
