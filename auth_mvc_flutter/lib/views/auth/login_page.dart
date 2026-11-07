import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../models/auth_models.dart';
import '../../utils/form_validators.dart';
import 'auth_widgets.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  final AuthController controller;
  const LoginPage({super.key, required this.controller});
  @override State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _rememberMe = false;

  @override
  void dispose() { _identifier.dispose(); _password.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await widget.controller.login(LoginRequest(identifier: _identifier.text.trim(), password: _password.text, rememberMe: _rememberMe));
    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تسجيل الدخول بنجاح'), backgroundColor: Colors.green));
    } else if (widget.controller.errorMessage != null) showError(context, widget.controller.errorMessage!);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: widget.controller,
    builder: (_, __) => AuthScaffold(
      title: 'بوابة الطالب', subtitle: 'تسجيل دخول آمن إلى حسابك الأكاديمي',
      child: Card(
        elevation: 0, color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(padding: const EdgeInsets.all(20), child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          AuthTextField(controller: _identifier, label: 'المعرف الأكاديمي أو البريد', icon: Icons.person_outline, validator: FormValidators.loginIdentifier),
          AuthTextField(controller: _password, label: 'كلمة المرور', icon: Icons.lock_outline, validator: FormValidators.password, obscureText: _obscure, onToggleObscure: () => setState(() => _obscure = !_obscure)),
          Row(children: [Checkbox(value: _rememberMe, activeColor: teal, onChanged: (v) => setState(() => _rememberMe = v ?? false)), const Text('تذكرني'), const Spacer(), TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordPage(controller: widget.controller))), child: const Text('نسيت كلمة المرور؟'))]),
          const SizedBox(height: 8), PrimaryButton(label: 'تسجيل الدخول', loading: widget.controller.isLoading, onPressed: _submit),
          const SizedBox(height: 16), Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('ليس لديك حساب؟'), TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage(controller: widget.controller))), child: const Text('إنشاء حساب جديد'))]),
        ])),
      ),
    ),
  );
}
