import 'package:flutter/material.dart';
import 'home_screen.dart';

// Екран 2: Onboarding Quiz
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Запазваме избора на потребителя
  final TextEditingController _heightController = TextEditingController();
  String _selectedBodyShape = '';
  String _selectedSkinTone = 'Fair';
  String _selectedStyle = '';

  // Списък с опции за тен
  final List<String> _skinTones = ['Fair', 'Light', 'Medium', 'Olive', 'Brown', 'Dark'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 16),

              // Заглавие
              const Text(
                'Tell us about\nyourself',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE8D5B7),
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "We'll personalize your outfit suggestions",
                style: TextStyle(fontSize: 14, color: Color(0xFF888888)),
              ),

              const SizedBox(height: 36),

              // --- Въпрос 1: Височина ---
              _buildSectionTitle('Your height (cm)'),
              const SizedBox(height: 10),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'e.g. 165',
                  hintStyle: const TextStyle(color: Color(0xFF555555)),
                  filled: true,
                  fillColor: const Color(0xFF2D2D44),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 16,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // --- Въпрос 2: Форма на тялото ---
              _buildSectionTitle('Body shape'),
              const SizedBox(height: 10),
              _buildChoiceRow(
                options: ['Hourglass', 'Pear', 'Apple', 'Rectangle'],
                selected: _selectedBodyShape,
                onSelect: (val) => setState(() => _selectedBodyShape = val),
              ),

              const SizedBox(height: 28),

              // --- Въпрос 3: Тен ---
              _buildSectionTitle('Skin tone'),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D44),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedSkinTone,
                    isExpanded: true,
                    dropdownColor: const Color(0xFF2D2D44),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    items: _skinTones.map((tone) {
                      return DropdownMenuItem(value: tone, child: Text(tone));
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedSkinTone = val!),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // --- Въпрос 4: Предпочитан стил ---
              _buildSectionTitle('Preferred style'),
              const SizedBox(height: 10),
              _buildChoiceRow(
                options: ['Casual', 'Street', 'Elegant', 'Minimal'],
                selected: _selectedStyle,
                onSelect: (val) => setState(() => _selectedStyle = val),
              ),

              const SizedBox(height: 40),

              // Бутон завърши
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
                    // Проверяваме дали е попълнена височината
                    if (_heightController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter your height')),
                      );
                      return;
                    }
                    // Отиваме към Home
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  child: const Text(
                    'Find My Style →',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Помощен метод: заглавие на секция
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE8D5B7),
      ),
    );
  }

  // Помощен метод: ред с бутони за избор
  Widget _buildChoiceRow({
    required List<String> options,
    required String selected,
    required Function(String) onSelect,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        bool isSelected = selected == option;
        return GestureDetector(
          onTap: () => onSelect(option),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFE8D5B7) : const Color(0xFF2D2D44),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? const Color(0xFF1A1A2E) : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}