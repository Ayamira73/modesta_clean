import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ModestApp());
}

class ModestApp extends StatelessWidget {
  const ModestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modesta',
      debugShowCheckedModeBanner: false,
      // FARBEN
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFE8D5B7),
          secondary: const Color(0xFFE8D5B7),
          surface: const Color(0xFF2D2D44),
        ),
        useMaterial3: true,
      ),
      // the first screen that will open
      home: const SplashScreen(),
    );
  }
}