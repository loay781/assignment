import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../models/auth_models.dart';
import '../../utils/form_validators.dart';
import 'auth_widgets.dart';

class ResetPasswordPage extends StatefulWidget {
  final AuthController controller;
  final String identifier;
  const ResetPasswordPage({super.key, required this.controller, required this.identifier});
  @override State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _otp = TextEditingController(), _password = TextEditingController(), _confirm = TextEditingController();
  bool _obscure = true, _obscureConfirm = true;
  @override void dispose() { _otp.dispose(); _password.dispose(); _confirm.dispose(); super.dispose(); }
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await widget.controller.resetPassword(PasswordResetRequest(identifier: widget.identifier, otp: _otp.text.trim(), newPassword: _password.text));
    if (!mounted) return;
    if (ok) {
      await showDialog<void>(context: context, builder: (_) => AlertDialog(title: const Text('تم بنجاح'), content: const Text('تم تحديث كلمة المرور بنجاح. يمكنك تسجيل الدخول الآن.'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسنًا'))]));
      if (mounted) Navigator.popUntil(context, (route) => route.isFirst);
    } else if (widget.controller.errorMessage != null) showError(context, widget.controller.errorMessage!);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(animation: widget.controller, builder: (_, __) => AuthScaffold(title: 'كلمة مرور جديدة', subtitle: 'أدخل الرمز ثم اختر كلمة مرور قوية', child: Card(elevation: 0, color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), child: Padding(padding: const EdgeInsets.all(20), child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    AuthTextField(controller: _otp, label: 'رمز التحقق (6 أرقام)', icon: Icons.pin_outlined, keyboardType: TextInputType.number, maxLength: 6, validator: FormValidators.otp),
    AuthTextField(controller: _password, label: 'كلمة المرور الجديدة', icon: Icons.lock_outline, obscureText: _obscure, onToggleObscure: () => setState(() => _obscure = !_obscure), validator: FormValidators.strongPassword),
    AuthTextField(controller: _confirm, label: 'تأكيد كلمة المرور الجديدة', icon: Icons.lock_reset, obscureText: _obscureConfirm, onToggleObscure: () => setState(() => _obscureConfirm = !_obscureConfirm), validator: (v) => FormValidators.confirmation(v, _password.text)),
    const SizedBox(height: 8), PrimaryButton(label: 'تحديث كلمة المرور', loading: widget.controller.isLoading, onPressed: _submit),
  ]))));
}
