import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ModestaApp());
}

class ModestaApp extends StatelessWidget {
  const ModestaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modesta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F5EB),
        primaryColor: const Color(0xFFA47551),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFA47551),
          primary: const Color(0xFFA47551),
          secondary: const Color(0xFF8FAE8B),
          surface: const Color(0xFFFFFDF7),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF9F5EB),
          foregroundColor: Color(0xFF3A2A1F),
          elevation: 0,
          centerTitle: false,
        ),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        '/quiz': (_) => const QuizScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
