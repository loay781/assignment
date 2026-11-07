import 'package:flutter/material.dart';
import 'controllers/auth_controller.dart';
import 'repositories/auth_repository_impl.dart';
import 'views/auth/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final controller = AuthController(repository: AuthRepositoryImpl());
  runApp(StudentAuthApp(controller: controller));
}

class StudentAuthApp extends StatelessWidget {
  final AuthController controller;
  const StudentAuthApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'بوابة الطالب',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Arial', colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E7490))),
      builder: (context, child) => Directionality(textDirection: TextDirection.rtl, child: child ?? const SizedBox.shrink()),
      home: LoginPage(controller: controller),
    );
  }
}
