import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/form_validators.dart';
import 'auth_widgets.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  final AuthController controller;
  const ForgotPasswordPage({super.key, required this.controller});
  @override State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  @override void dispose() { _identifier.dispose(); super.dispose(); }
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final id = _identifier.text.trim();
    final ok = await widget.controller.sendPasswordResetCode(id);
    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال رمز التحقق بنجاح'), backgroundColor: Colors.green));
      Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPasswordPage(controller: widget.controller, identifier: id)));
    } else if (widget.controller.errorMessage != null) showError(context, widget.controller.errorMessage!);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(animation: widget.controller, builder: (_, __) => AuthScaffold(title: 'استعادة الحساب', subtitle: 'استرجع وصولك إلى حسابك بأمان', child: Card(elevation: 0, color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), child: Padding(padding: const EdgeInsets.all(20), child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFE5F6F8), borderRadius: BorderRadius.circular(14)), child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.info_outline, color: teal), SizedBox(width: 10), Expanded(child: Text('سنرسل رمز تحقق مؤقتًا إلى وسيلة التواصل المرتبطة بحسابك. أدخل البريد الجامعي أو الرقم الأكاديمي للمتابعة.'))])),
    const SizedBox(height: 22), AuthTextField(controller: _identifier, label: 'البريد أو الرقم الأكاديمي', icon: Icons.alternate_email, validator: FormValidators.loginIdentifier),
    PrimaryButton(label: 'إرسال رمز التحقق', loading: widget.controller.isLoading, onPressed: _submit), const SizedBox(height: 8),
    TextButton(onPressed: () => Navigator.pop(context), child: const Text('العودة لتسجيل الدخول')),
  ]))));
}
