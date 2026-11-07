import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../models/auth_models.dart';
import '../../utils/form_validators.dart';
import 'auth_widgets.dart';

class RegisterPage extends StatefulWidget {
  final AuthController controller;
  const RegisterPage({super.key, required this.controller});
  @override State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController(), _academicId = TextEditingController(), _email = TextEditingController(), _password = TextEditingController(), _confirm = TextEditingController();
  bool _obscure = true, _obscureConfirm = true, _accepted = false;
  @override void dispose() { for (final c in [_name, _academicId, _email, _password, _confirm]) { c.dispose(); } super.dispose(); }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_accepted) { showError(context, 'يجب الموافقة على اللوائح والشروط الأكاديمية'); return; }
    final ok = await widget.controller.register(RegisterRequest(fullName: _name.text.trim(), academicId: _academicId.text.trim(), universityEmail: _email.text.trim(), password: _password.text));
    if (!mounted) return;
    if (ok) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إنشاء الحساب بنجاح'), backgroundColor: Colors.green)); Navigator.pop(context); }
    else if (widget.controller.errorMessage != null) showError(context, widget.controller.errorMessage!);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(animation: widget.controller, builder: (_, __) => AuthScaffold(title: 'إنشاء حساب', subtitle: 'أنشئ حسابك الأكاديمي خلال لحظات', child: Card(elevation: 0, color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), child: Padding(padding: const EdgeInsets.all(20), child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    AuthTextField(controller: _name, label: 'الاسم الكامل', icon: Icons.badge_outlined, validator: FormValidators.fullName),
    AuthTextField(controller: _academicId, label: 'الرقم الأكاديمي', icon: Icons.numbers, keyboardType: TextInputType.number, maxLength: 10, validator: FormValidators.academicId),
    AuthTextField(controller: _email, label: 'البريد الجامعي', icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, validator: FormValidators.universityEmail),
    AuthTextField(controller: _password, label: 'كلمة المرور', icon: Icons.lock_outline, obscureText: _obscure, onToggleObscure: () => setState(() => _obscure = !_obscure), validator: FormValidators.strongPassword),
    AuthTextField(controller: _confirm, label: 'تأكيد كلمة المرور', icon: Icons.lock_reset, obscureText: _obscureConfirm, onToggleObscure: () => setState(() => _obscureConfirm = !_obscureConfirm), validator: (v) => FormValidators.confirmation(v, _password.text)),
    CheckboxListTile(value: _accepted, onChanged: (v) => setState(() => _accepted = v ?? false), activeColor: teal, contentPadding: EdgeInsets.zero, title: const Text('أوافق على اللوائح والشروط الأكاديمية', style: TextStyle(fontSize: 13))),
    const SizedBox(height: 8), PrimaryButton(label: 'إنشاء الحساب', loading: widget.controller.isLoading, onPressed: _submit),
    const SizedBox(height: 8), TextButton(onPressed: () => Navigator.pop(context), child: const Text('لدي حساب بالفعل — تسجيل الدخول')),
  ])))));
}
