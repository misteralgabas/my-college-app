import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const AlgabasApp());
}

class AlgabasApp extends StatelessWidget {
  const AlgabasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALGABAS',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
