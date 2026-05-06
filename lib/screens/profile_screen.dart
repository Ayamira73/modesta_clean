import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Avatar
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: const Color(0xFF8DAA81).withOpacity(0.2),
                  child: const Icon(Icons.person, size: 52, color: Color(0xFF8DAA81)),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF8DAA81),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, size: 14, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Sofia Style',
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D3D3D),
              ),
            ),
            const Text(
              '@sofia.style',
              style: TextStyle(fontSize: 13, color: Color(0xFF8DAA81)),
            ),
            const SizedBox(height: 20),
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _stat('48', 'Outfits'),
                _divider(),
                _stat('1.2k', 'Followers'),
                _divider(),
                _stat('320', 'Following'),
              ],
            ),
            const SizedBox(height: 24),
            // Edit button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF8DAA81)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Color(0xFF8DAA81)),
                ),
              ),
            ),
            const SizedBox(height: 28),
            // My Closet
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Closet',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3D3D3D),
                  ),
                ),
                Text('See all', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 14),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 9,
              itemBuilder: (context, i) {
                final colors = [
                  const Color(0xFFD6E4CF),
                  const Color(0xFFE8DDD0),
                  const Color(0xFFCDD9E5),
                  const Color(0xFFEDE3D5),
                  const Color(0xFFD9D4E7),
                  const Color(0xFFE2EAD8),
                  const Color(0xFFD5CDBF),
                  const Color(0xFFEAD5D5),
                  const Color(0xFFD5E1EA),
                ];
                return Container(
                  decoration: BoxDecoration(
                    color: colors[i],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(Icons.checkroom, color: Colors.white60, size: 28),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3D3D3D))),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
      ],
    );
  }

  Widget _divider() {
    return Container(height: 32, width: 1, color: Colors.grey.shade200);
  }
}
