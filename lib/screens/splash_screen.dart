import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'home_screen.dart';

// Екран 1: Начален екран
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Лого иконка
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D44),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.checkroom,
                size: 64,
                color: Color(0xFFE8D5B7),
              ),
            ),

            const SizedBox(height: 28),

            // Име на приложението
            const Text(
              'Modesta',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE8D5B7),
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 8),

            // Слоган
            const Text(
              'Dress your best, every day.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF888888),
              ),
            ),

            const SizedBox(height: 64),

            // Бутон Get Started
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8D5B7),
                  foregroundColor: const Color(0xFF1A1A2E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Отиваме към Quiz екрана
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizScreen()),
                  );
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Линк за вход
            GestureDetector(
              onTap: () {
                // Ако вече имаш акаунт - отиди директно в Home
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text(
                'Already have an account? Log in',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF888888),
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF888888),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 