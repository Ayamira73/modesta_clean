import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {

    await Future.delayed(const Duration(seconds: 2));


    const bool quizDone = false;

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => quizDone ? const HomeScreen() : const QuizScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5EB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF8DAA81),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.checkroom,
                color: Colors.white,
                size: 52,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Modesta',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D3D3D),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your personal style assistant',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF8DAA81),
              ),
            ),
          ],
        ),
      ),
    );
  }
}