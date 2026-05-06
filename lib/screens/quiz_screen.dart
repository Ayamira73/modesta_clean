import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _step = 0;
  final Map<String, String> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What\'s your style personality?',
      'options': ['Casual & Comfy', 'Elegant & Classy', 'Streetwear', 'Trendy & Bold'],
      'icons': [Icons.weekend, Icons.star, Icons.directions_walk, Icons.bolt],
    },
    {
      'question': 'Favourite colour palette?',
      'options': ['Neutrals & Beige', 'Pastels', 'Monochrome', 'Bright & Vivid'],
      'icons': [Icons.circle, Icons.color_lens, Icons.contrast, Icons.palette],
    },
    {
      'question': 'What occasions do you dress for most?',
      'options': ['Everyday', 'Work', 'Going out', 'Special events'],
      'icons': [Icons.wb_sunny, Icons.work, Icons.local_bar, Icons.celebration],
    },
  ];

  void _selectOption(String option) {
    setState(() {
      _answers['q$_step'] = option;
      if (_step < _questions.length - 1) {
        _step++;
      } else {
        // Done — show result
        _showResult();
      }
    });
  }

  void _showResult() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(28),
        decoration: const BoxDecoration(
          color: Color(0xFFF9F5EB),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.checkroom, size: 56, color: Color(0xFF8DAA81)),
            const SizedBox(height: 16),
            const Text('Your Style DNA',
                style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3D3D3D))),
            const SizedBox(height: 8),
            Text(
              'Based on your answers, you\'re a ${_answers['q0'] ?? 'Stylish'} type with a love for ${_answers['q1'] ?? 'beautiful'} tones.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8DAA81),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: const Text('See My Outfits',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_step];
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5EB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _step > 0
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Color(0xFF3D3D3D)),
          onPressed: () => setState(() => _step--),
        )
            : IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF3D3D3D)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress
            Row(
              children: List.generate(_questions.length, (i) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 6),
                    height: 4,
                    decoration: BoxDecoration(
                      color: i <= _step ? const Color(0xFF8DAA81) : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 36),
            Text(
              'Step ${_step + 1} of ${_questions.length}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
            ),
            const SizedBox(height: 10),
            Text(
              q['question'],
              style: const TextStyle(
                fontFamily: 'Georgia',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D3D3D),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 36),
            ...List.generate(q['options'].length, (i) {
              return GestureDetector(
                onTap: () => _selectOption(q['options'][i]),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(q['icons'][i], color: const Color(0xFF8DAA81), size: 22),
                      const SizedBox(width: 14),
                      Text(
                        q['options'][i],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3D3D3D),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
