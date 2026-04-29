import 'package:flutter/material.dart';
import 'home_screen.dart';

// Екран 5: Качване на аутфит
class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  String _selectedCategory = 'Casual';
  bool _photoAdded = false;

  final List<String> _categories = [
    'Casual', 'Street Style', 'Elegant', 'Minimalist', 'Sporty', 'Vintage'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12122A),
        elevation: 0,
        title: const Text(
          'Share Your Outfit',
          style: TextStyle(color: Color(0xFFE8D5B7), fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFFE8D5B7)),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Зона за качване на снимка
            GestureDetector(
              onTap: () {
                // В реалното приложение тук се отваря галерията
                setState(() => _photoAdded = true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening gallery...')),
                );
              },
              child: Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D44),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _photoAdded
                        ? const Color(0xFFE8D5B7)
                        : const Color(0xFF444466),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _photoAdded ? Icons.check_circle : Icons.add_photo_alternate_outlined,
                      size: 56,
                      color: _photoAdded
                          ? const Color(0xFFE8D5B7)
                          : const Color(0xFF666688),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _photoAdded ? 'Photo added!' : 'Tap to add photo',
                      style: TextStyle(
                        color: _photoAdded
                            ? const Color(0xFFE8D5B7)
                            : const Color(0xFF888888),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Описание
            _buildLabel('Description'),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Describe your outfit...'),
            ),

            const SizedBox(height: 20),

            // Тагове
            _buildLabel('Tag clothing items'),
            const SizedBox(height: 8),
            TextField(
              controller: _tagsController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('e.g. white sweater, black jeans, sneakers'),
            ),

            const SizedBox(height: 20),

            // Категория
            _buildLabel('Style category'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D44),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  dropdownColor: const Color(0xFF2D2D44),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  items: _categories.map((cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat));
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val!),
                ),
              ),
            ),

            const SizedBox(height: 36),

            // Бутон Публикуване
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
                  if (_descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please add a description')),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Outfit published! 🎉')),
                  );
                  // Отиваме към Home
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text(
                  'Publish Outfit',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Бутон Отказ
            SizedBox(
              width: double.infinity,
              height: 52,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF888888), fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Помощен метод: заглавие на поле
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFFE8D5B7),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Помощен метод: декорация за TextField
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF555555)),
      filled: true,
      fillColor: const Color(0xFF2D2D44),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}