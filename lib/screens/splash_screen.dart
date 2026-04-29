import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Hintergrund auf unser helles Beige ändern
      backgroundColor: const Color(0xFFF9F5EB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Das Logo-Icon in einem sanften Pistazien-Rahmen
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF8DAA81).withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.checkroom,
                size: 64,
                color: Color(0xFF8DAA81), // Pistaziengrün
              ),
            ),

            const SizedBox(height: 28),

            // Name der App in dunklerem Text für besseren Kontrast auf Beige
            const Text(
              'Modesta',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 8),

            // Slogan
            const Text(
              'Dress your best, every day.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF777777),
              ),
            ),

            const SizedBox(height: 64),

            // "Get Started" Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8DAA81),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
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

            // Login Link
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text(
                'Already have an account? Log in',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8DAA81),
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}