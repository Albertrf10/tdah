import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final user = TextEditingController();

  String error = '';

  void register() async {
    try {
      await ref.read(authControllerProvider.notifier).register(
        email.text,
        pass.text,
        user.text,
      );
    } catch (e) {
      setState(() => error = "Error register");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: user, decoration: const InputDecoration(labelText: "Username")),
            TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: pass, obscureText: true, decoration: const InputDecoration(labelText: "Password")),

            const SizedBox(height: 10),
            Text(error, style: const TextStyle(color: Colors.red)),

            ElevatedButton(
              onPressed: register,
              child: const Text("Crear cuenta"),
            ),
          ],
        ),
      ),
    );
  }
}