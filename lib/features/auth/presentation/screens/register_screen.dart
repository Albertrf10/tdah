import 'package:flutter/material.dart';
import 'package:tdah_app/features/auth/data/auth_datasource.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final userController = TextEditingController();
  final passController = TextEditingController();
  final repeatPassController = TextEditingController();

  final auth = AuthDataSource();

  String error = '';

  void register() async {
    if (passController.text != repeatPassController.text) {
      setState(() => error = "Las contraseñas no coinciden");
      return;
    }

    await auth.register(
      email: emailController.text,
      password: passController.text,
      username: userController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: userController, decoration: const InputDecoration(labelText: "Username")),
            TextField(controller: passController, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
            TextField(controller: repeatPassController, obscureText: true, decoration: const InputDecoration(labelText: "Repeat Password")),
            const SizedBox(height: 10),
            Text(error, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: register,
              child: const Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}