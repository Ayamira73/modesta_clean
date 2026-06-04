import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker _picker = ImagePicker();
  String _selectedCategory = 'Elegant';
  String _selectedColor = 'Ivory';
  String _selectedSeason = 'Autumn';
  bool _saveToWardrobe = true;
  bool _isPublishing = false;
  String _uploadStatus = '';
  XFile? _selectedImage;
  String? _selectedImageName;
  Uint8List? _selectedImageBytes;

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
      _selectedImage = null;
      _selectedImageName = null;
      _selectedImageBytes = null;
      _saveToWardrobe = true;
      _selectedCategory = 'Elegant';
      _selectedColor = 'Ivory';
      _selectedSeason = 'Autumn';
    });
  }

  Future<User> _ensureSignedInUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) return currentUser;

    throw FirebaseAuthException(
      code: 'user-not-found',
      message: 'Sign in before uploading a post.',
    );
  }

  String _friendlyUploadError(Object error) {
    if (error is TimeoutException) {
      return 'Firebase timed out while: $_uploadStatus. Check Firestore rules and Anonymous Auth.';
    }

    if (error is FirebaseException) {
      if (error.code == 'unauthorized' || error.code == 'permission-denied') {
        return 'Firebase rules blocked saving the post. Enable anonymous auth or allow authenticated users to write to Firestore.';
      }
      if (error.code == 'operation-not-allowed') {
        return 'Anonymous sign-in is disabled in Firebase Authentication. Enable it or sign in before uploading.';
      }
      return '${error.plugin}: ${error.message ?? error.code}';
    }

    return error.toString();
  }

  Future<void> _pickPhoto() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 45,
        maxWidth: 800,
        maxHeight: 1000,
      );

      if (image == null) return;
      final imageBytes = await image.readAsBytes();

      setState(() {
        _selectedImage = image;
        _selectedImageName = image.name;
        _selectedImageBytes = imageBytes;
      });
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open gallery: $error')),
      );
    }
  }

  Future<void> _publishPost() async {
    final caption = _captionController.text.trim();

    if (caption.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add a caption first.')),
      );
      return;
    }

    setState(() {
      _isPublishing = true;
      _uploadStatus = 'Preparing upload...';
    });

    try {
      setState(() => _uploadStatus = 'Checking account...');
      final user = await _ensureSignedInUser();
      final uid = user.uid;
      String? imageBase64;

      if (_selectedImageBytes != null) {
        setState(() => _uploadStatus = 'Preparing photo...');
        if (_selectedImageBytes!.length > 600000) {
          throw Exception('Please choose a smaller image.');
        }
        imageBase64 = base64Encode(_selectedImageBytes!);
      }

      final tags = _tagsController.text
          .split(',')
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList();

      final postData = {
        'caption': caption,
        'category': _selectedCategory,
        'color': _selectedColor,
        'season': _selectedSeason,
        'tags': tags,
        'imageUrl': null,
        'imageBase64': imageBase64,
        'localImageName': _selectedImageName,
        'imageUploadPending': false,
        'userId': uid,
        'userName':
            user.displayName ?? user.email?.split('@').first ?? 'Modesta User',
        'userEmail': user.email,
        'saveToWardrobe': _saveToWardrobe,
        'likesCount': 0,
        'commentsCount': 0,
        'createdAt': FieldValue.serverTimestamp(),
      };

      setState(() => _uploadStatus = 'Saving post...');
      final postRef = await FirebaseFirestore.instance
          .collection('outfit_posts')
          .add(postData)
          .timeout(const Duration(seconds: 20));

      if (_saveToWardrobe) {
        setState(() => _uploadStatus = 'Saving to wardrobe...');
        await FirebaseFirestore.instance.collection('wardrobe_items').add({
          ...postData,
          'postId': postRef.id,
        }).timeout(const Duration(seconds: 20));
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your post was published.')),
      );
      _clearForm();
      if (!widget.isEmbedded) Navigator.pop(context);
    } catch (error) {
      debugPrint('Modesta upload failed at "$_uploadStatus": $error');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Upload failed: ${_friendlyUploadError(error)}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isPublishing = false;
          _uploadStatus = '';
        });
      }
    }
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
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: ListView(
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
                      'Add a photo and details to share your outfit.',
                      style:
                          TextStyle(color: _muted, fontSize: 12, height: 1.4),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _isPublishing ? null : _pickPhoto,
                      child: Container(
                        height: _selectedImageBytes == null ? 230 : 320,
                        decoration: BoxDecoration(
                          color: _selectedImage != null
                              ? const Color(0xFFE8DCC8)
                              : _bg,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: _selectedImage != null ? _brown : _beige,
                            width: 1.4,
                          ),
                        ),
                        child: _selectedImageBytes == null
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 54,
                                      color: _muted,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Add outfit photo',
                                      style: TextStyle(
                                        color: _text,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      'Choose a photo from your gallery',
                                      style: TextStyle(
                                        color: _muted,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.memory(
                                      _selectedImageBytes!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    left: 14,
                                    right: 14,
                                    bottom: 14,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 11,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _card.withValues(alpha: 0.88),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: _beige),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.check_circle_rounded,
                                            color: _brown,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              _selectedImageName ?? 'Photo',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: _text,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Change',
                                            style: TextStyle(
                                              color: _brown,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                      decoration:
                          _inputDecoration('e.g. ivory, modest, workwear'),
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
                      onChanged: (value) =>
                          setState(() => _selectedSeason = value),
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      value: _saveToWardrobe,
                      onChanged: (value) =>
                          setState(() => _saveToWardrobe = value),
                      contentPadding: EdgeInsets.zero,
                      activeThumbColor: _brown,
                      title: const Text(
                        'Save to wardrobe',
                        style: TextStyle(
                            color: _text, fontWeight: FontWeight.w800),
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
                        onPressed: _isPublishing ? null : _publishPost,
                        child: _isPublishing
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: _card,
                                ),
                              )
                            : const Text(
                                'Publish Post',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w900),
                              ),
                      ),
                    ),
                    if (_isPublishing && _uploadStatus.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          _uploadStatus,
                          style: const TextStyle(
                            color: _muted,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
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
                        onPressed: _isPublishing ? null : _clearForm,
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
        ),
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
