// lib/main.dart

import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // obligatoire avant SharedPreferences
  await di.init(); // on câble tout
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Clean',
      home: Scaffold(body: Center(child: Text('Phase 3 OK — Domain câblé'))),
    );
  }
}
