import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const Color _card = Color(0xFFFFFDF7);
const Color _text = Color(0xFF3A2A1F);
const Color _brown = Color(0xFFA47551);
const Color _beige = Color(0xFFE8DCC8);
const Color _muted = Color(0xFF8C7A6B);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _picker = ImagePicker();
  bool _isUploadingPhoto = false;

  User? get _user => FirebaseAuth.instance.currentUser;

  Future<void> _pickProfilePhoto() async {
    final user = _user;
    if (user == null || _isUploadingPhoto) return;

    try {
      final image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 45,
        maxWidth: 600,
        maxHeight: 600,
      );
      if (image == null) return;

      setState(() => _isUploadingPhoto = true);
      final Uint8List bytes = await image.readAsBytes();
      if (bytes.length > 600000) {
        throw Exception('Please choose a smaller image.');
      }
      final imageBase64 = base64Encode(bytes);

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'profileImageBase64': imageBase64,
        'email': user.email,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      if (mounted) setState(() {});
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not upload profile photo: $error')),
      );
    } finally {
      if (mounted) setState(() => _isUploadingPhoto = false);
    }
  }

  Future<void> _editName() async {
    final user = _user;
    if (user == null) return;

    final controller = TextEditingController(text: user.displayName ?? '');
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _card,
        title: const Text('Edit profile name'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Your name',
            prefixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name == null || name.isEmpty) return;

    try {
      await user.updateDisplayName(name);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'displayName': name,
        'email': user.email,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      await user.reload();
      if (mounted) setState(() {});
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not update name: $error')),
      );
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _postsStream() {
    return FirebaseFirestore.instance
        .collection('outfit_posts')
        .where('userId', isEqualTo: _user?.uid ?? '')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final user = _user;
    final displayName =
        user?.displayName ?? user?.email?.split('@').first ?? 'Modesta User';

    return SafeArea(
      top: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: _beige),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: user == null
                          ? null
                          : FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .snapshots(),
                      builder: (context, snapshot) {
                        final imageBase64 = snapshot.data
                            ?.data()?['profileImageBase64'] as String?;
                        return CircleAvatar(
                          radius: 52,
                          backgroundColor: _beige,
                          backgroundImage: imageBase64 == null
                              ? null
                              : MemoryImage(base64Decode(imageBase64)),
                          child: imageBase64 == null
                              ? const Icon(Icons.person_rounded,
                                  size: 58, color: _brown)
                              : null,
                        );
                      },
                    ),
                    Material(
                      color: _brown,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: _pickProfilePhoto,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: _isUploadingPhoto
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.add_a_photo_rounded,
                                  size: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  displayName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _text,
                    fontFamily: 'Georgia',
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? '',
                  style: const TextStyle(color: _muted, fontSize: 13),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton.icon(
                    onPressed: _editName,
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Edit profile name'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _brown,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'My posts',
            style: TextStyle(
              color: _text,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _postsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(color: _brown),
                  ),
                );
              }

              final posts = snapshot.data?.docs ?? [];
              if (posts.isEmpty) {
                return const _EmptyPosts();
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.78,
                ),
                itemCount: posts.length,
                itemBuilder: (context, index) =>
                    _ProfilePost(data: posts[index].data()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProfilePost extends StatelessWidget {
  const _ProfilePost({required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final imageUrl = data['imageUrl'] as String?;
    final imageBase64 = data['imageBase64'] as String?;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _beige),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: imageBase64 != null
                ? Image.memory(
                    base64Decode(imageBase64),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : imageUrl == null || imageUrl.isEmpty
                    ? const ColoredBox(
                        color: _beige,
                        child: Center(
                          child: Icon(Icons.checkroom_rounded,
                              color: _brown, size: 42),
                        ),
                      )
                    : Image.network(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              data['caption'] ?? 'My outfit',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _text,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyPosts extends StatelessWidget {
  const _EmptyPosts();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 20),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _beige),
      ),
      child: const Column(
        children: [
          Icon(Icons.add_photo_alternate_outlined, color: _brown, size: 46),
          SizedBox(height: 10),
          Text(
            'Your published posts will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
