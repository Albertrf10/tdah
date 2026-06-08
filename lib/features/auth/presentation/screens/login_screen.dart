import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdah_app/features/auth/controllers/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final inputController = TextEditingController();
  final passController = TextEditingController();

  String error = '';

  void loginEmail() async {
    try {
      await ref.read(authControllerProvider.notifier).loginEmail(
        inputController.text,
        passController.text,
      );
    } catch (e) {
      setState(() => error = "Error login");
    }
  }

  void loginGoogle() async {
    await ref.read(authControllerProvider.notifier).loginGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: inputController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 10),
            Text(error, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: loginEmail,
              child: const Text("Login"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: loginGoogle,
              child: const Text("Login con Google"),
            ),
          ],
        ),
      ),
    );
  }
}