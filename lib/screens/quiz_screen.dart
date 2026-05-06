import 'package:flutter/material.dart';
import 'home_screen.dart';

// NOTE: To enable "first launch only" behaviour, add shared_preferences to
// pubspec.yaml, then uncomment the SharedPreferences lines below.

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
      'question': 'What is your body shape?',
      'subtitle': 'We\'ll suggest outfits that flatter your figure.',
      'options': ['Hourglass', 'Pear', 'Apple', 'Rectangle', 'Inverted Triangle'],
      'icons': [
        Icons.accessibility_new,
        Icons.woman,
        Icons.circle,
        Icons.rectangle,
        Icons.change_history,
      ],
    },
    {
      'question': 'What is your skin tone?',
      'subtitle': 'We\'ll match colours that complement you best.',
      'options': ['Fair', 'Light', 'Medium', 'Olive', 'Tan', 'Deep'],
      'icons': [
        Icons.circle,
        Icons.circle,
        Icons.circle,
        Icons.circle,
        Icons.circle,
        Icons.circle,
      ],
      'colors': [
        Color(0xFFF9DCC4),
        Color(0xFFF1C27D),
        Color(0xFFE0AC69),
        Color(0xFFC68642),
        Color(0xFF8D5524),
        Color(0xFF4A2912),
      ],
    },
    {
      'question': 'What\'s your style personality?',
      'subtitle': 'Pick the vibe that feels most like you.',
      'options': ['Casual & Comfy', 'Elegant & Classy', 'Streetwear', 'Trendy & Bold'],
      'icons': [Icons.weekend, Icons.star, Icons.directions_walk, Icons.bolt],
    },
    {
      'question': 'Favourite colour palette?',
      'subtitle': 'This helps us filter your outfit feed.',
      'options': ['Neutrals & Beige', 'Pastels', 'Monochrome', 'Bright & Vivid'],
      'icons': [Icons.circle, Icons.color_lens, Icons.contrast, Icons.palette],
    },
    {
      'question': 'What occasions do you dress for most?',
      'subtitle': 'We\'ll prioritise the right outfit types for you.',
      'options': ['Everyday', 'Work', 'Going out', 'Special events'],
      'icons': [Icons.wb_sunny, Icons.work, Icons.local_bar, Icons.celebration],
    },
  ];

  void _selectOption(String option) {
    _answers['q$_step'] = option;
    if (_step < _questions.length - 1) {
      setState(() => _step++);
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
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
            const Text(
              'Your Style Profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D3D3D),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'You\'re a ${_answers['q2'] ?? 'Stylish'} type with a love for ${_answers['q3'] ?? 'beautiful'} tones — dressed for ${_answers['q4'] ?? 'every occasion'}.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.6),
            ),
            const SizedBox(height: 6),
            Text(
              'Body shape: ${_answers['q0'] ?? '-'}  •  Skin tone: ${_answers['q1'] ?? '-'}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Color(0xFF8DAA81)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Uncomment when shared_preferences is added:
                  // final prefs = await SharedPreferences.getInstance();
                  // await prefs.setBool('quiz_done', true);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8DAA81),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'See My Outfits',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_step];
    final List<String> options = List<String>.from(q['options']);
    final List<IconData> icons = List<IconData>.from(q['icons']);
    final List<Color>? colors =
    q['colors'] != null ? List<Color>.from(q['colors']) : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5EB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // No close button — quiz is mandatory on first launch
        leading: _step > 0
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Color(0xFF3D3D3D)),
          onPressed: () => setState(() => _step--),
        )
            : const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            Row(
              children: List.generate(_questions.length, (i) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 6),
                    height: 4,
                    decoration: BoxDecoration(
                      color: i <= _step
                          ? const Color(0xFF8DAA81)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            Text(
              'Step ${_step + 1} of ${_questions.length}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
            ),
            const SizedBox(height: 8),
            Text(
              q['question'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D3D3D),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              q['subtitle'],
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 24),

            // Answer options
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () => _selectOption(options[i]),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
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
                          // Skin tone: coloured circle. Other questions: icon.
                          colors != null
                              ? Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: colors[i],
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                          )
                              : Icon(icons[i],
                              color: const Color(0xFF8DAA81), size: 22),
                          const SizedBox(width: 14),
                          Text(
                            options[i],
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}