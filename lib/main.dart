import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ModestaApp());
}

class ModestaApp extends StatelessWidget {
  const ModestaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modesta',
      theme: ThemeData(
        // Farbpalette
        scaffoldBackgroundColor: const Color(0xFFF9F5EB), // Beige
        primaryColor: const Color(0xFF8DAA81),           // Pistazien-Grün
      ),
      home: const SplashScreen(),
    );
  }
}
