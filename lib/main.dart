import 'package:flutter/material.dart';
import 'package:tdah_app/core/firebase/firebase_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseInit.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text("App funcionando 🚀")),
      ),
    );
  }
}