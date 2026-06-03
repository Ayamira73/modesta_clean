import 'package:flutter/material.dart';

const Color _bg = Color(0xFFF9F5EB);
const Color _card = Color(0xFFFFFDF7);
const Color _text = Color(0xFF3A2A1F);
const Color _brown = Color(0xFFA47551);
const Color _beige = Color(0xFFE8DCC8);
const Color _muted = Color(0xFF8C7A6B);

class UploadScreen extends StatefulWidget {
  final bool isEmbedded;

  const UploadScreen({super.key, this.isEmbedded = false});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  String _selectedCategory = 'Elegant';
  String _selectedColor = 'Ivory';
  String _selectedSeason = 'Autumn';
  bool _photoAdded = false;
  bool _saveToWardrobe = true;

  final List<String> _categories = const [
    'Elegant',
    'Casual',
    'Workwear',
    'Evening',
    'Minimal',
  ];
  final List<String> _colors = const [
    'Ivory',
    'Camel',
    'Sage',
    'Taupe',
    'Cream'
  ];
  final List<String> _seasons = const ['Autumn', 'Winter', 'Spring', 'Summer'];

  @override
  void dispose() {
    _captionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _captionController.clear();
    _tagsController.clear();
    setState(() {
      _photoAdded = false;
      _saveToWardrobe = true;
      _selectedCategory = 'Elegant';
      _selectedColor = 'Ivory';
      _selectedSeason = 'Autumn';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: widget.isEmbedded
          ? null
          : AppBar(
              title: const Text('Share Your Outfit'),
              leading: IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 26),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: _beige),
              boxShadow: [
                BoxShadow(
                  color: _brown.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create a fashion post',
                  style: TextStyle(
                    color: _text,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Upload a look, tag the mood, and save it to your wardrobe.',
                  style: TextStyle(color: _muted, fontSize: 12, height: 1.4),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    setState(() => _photoAdded = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Opening gallery...')),
                    );
                  },
                  child: Container(
                    height: 230,
                    decoration: BoxDecoration(
                      color: _photoAdded ? const Color(0xFFE8DCC8) : _bg,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: _photoAdded ? _brown : _beige,
                        width: 1.4,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _photoAdded
                                ? Icons.check_circle_rounded
                                : Icons.add_photo_alternate_outlined,
                            size: 54,
                            color: _photoAdded ? _brown : _muted,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _photoAdded
                                ? 'Photo selected'
                                : 'Upload outfit photo',
                            style: const TextStyle(
                              color: _text,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const _Label('Caption'),
                TextField(
                  controller: _captionController,
                  maxLines: 3,
                  style: const TextStyle(color: _text),
                  decoration: _inputDecoration(
                      'Describe the styling, occasion, and pieces...'),
                ),
                const SizedBox(height: 16),
                const _Label('Style tags'),
                TextField(
                  controller: _tagsController,
                  style: const TextStyle(color: _text),
                  decoration: _inputDecoration('e.g. ivory, modest, workwear'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _DropdownField(
                        label: 'Category',
                        value: _selectedCategory,
                        items: _categories,
                        onChanged: (value) =>
                            setState(() => _selectedCategory = value),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _DropdownField(
                        label: 'Color',
                        value: _selectedColor,
                        items: _colors,
                        onChanged: (value) =>
                            setState(() => _selectedColor = value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _DropdownField(
                  label: 'Season',
                  value: _selectedSeason,
                  items: _seasons,
                  onChanged: (value) => setState(() => _selectedSeason = value),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  value: _saveToWardrobe,
                  onChanged: (value) => setState(() => _saveToWardrobe = value),
                  contentPadding: EdgeInsets.zero,
                  activeThumbColor: _brown,
                  title: const Text(
                    'Save to wardrobe',
                    style: TextStyle(color: _text, fontWeight: FontWeight.w800),
                  ),
                  subtitle: const Text(
                    'Keep this outfit in your private wardrobe grid.',
                    style: TextStyle(color: _muted, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _brown,
                      foregroundColor: _card,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      if (!_photoAdded ||
                          _captionController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Add a photo and caption first.'),
                          ),
                        );
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post published.')),
                      );
                      _clearForm();
                      if (!widget.isEmbedded) Navigator.pop(context);
                    },
                    child: const Text(
                      'Publish Post',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _brown,
                      side: const BorderSide(color: _beige),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _clearForm,
                    child: const Text(
                      'Save Draft to Wardrobe',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _muted, fontSize: 13),
      filled: true,
      fillColor: _bg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _beige),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _beige),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _brown),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: _text,
          fontWeight: FontWeight.w900,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(label),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          decoration: BoxDecoration(
            color: _bg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _beige),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: _card,
              icon:
                  const Icon(Icons.keyboard_arrow_down_rounded, color: _brown),
              style: const TextStyle(color: _text, fontWeight: FontWeight.w700),
              items: items
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (value) {
                if (value != null) onChanged(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
