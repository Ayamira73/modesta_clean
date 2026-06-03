import 'package:flutter/material.dart';
import '../widgets/outfit_card.dart';

const Color _card = Color(0xFFFFFDF7);
const Color _text = Color(0xFF3A2A1F);
const Color _brown = Color(0xFFA47551);
const Color _beige = Color(0xFFE8DCC8);
const Color _sage = Color(0xFF8FAE8B);
const Color _muted = Color(0xFF8C7A6B);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const savedLooks = [
      {
        'title': 'Office soft layers',
        'user': '@sofia.style',
        'color': Color(0xFFE8DCC8),
        'tags': ['office', 'camel'],
        'likes': '3.2k',
      },
      {
        'title': 'Ivory dinner look',
        'user': '@sofia.style',
        'color': Color(0xFFFFFDF7),
        'tags': ['evening', 'ivory'],
        'likes': '5.1k',
      },
    ];

    const wardrobe = [
      Color(0xFFE8DCC8),
      Color(0xFFD9C8AE),
      Color(0xFFFFFDF7),
      Color(0xFFD6E4CF),
      Color(0xFFEADFD1),
      Color(0xFFE5D9C3),
      Color(0xFFD8C4B6),
      Color(0xFFF0E6D8),
      Color(0xFFE2D5C2),
    ];

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
              boxShadow: [
                BoxShadow(
                  color: _brown.withValues(alpha: 0.05),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 48,
                          backgroundColor: _beige,
                          child: Icon(Icons.person_rounded,
                              size: 54, color: _brown),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: _brown,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add_a_photo_rounded,
                              size: 15, color: _card),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sophia Style',
                            style: TextStyle(
                              color: _text,
                              fontFamily: 'Georgia',
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            '@sofia.style',
                            style: TextStyle(color: _brown, fontSize: 13),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Soft neutrals, modest silhouettes, capsule wardrobe styling, and polished daily looks.',
                            style: TextStyle(
                              color: _muted,
                              fontSize: 12,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _stat('48', 'Posts'),
                    _divider(),
                    _stat('18.2k', 'Followers'),
                    _divider(),
                    _stat('320', 'Following'),
                  ],
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(
                        child: _ProfileButton(
                            label: 'Edit Profile', filled: true)),
                    SizedBox(width: 10),
                    Expanded(child: _ProfileButton(label: 'Share Profile')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Style preferences',
            style: TextStyle(
                color: _text, fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Preference(label: 'Elegant'),
              _Preference(label: 'Warm neutrals'),
              _Preference(label: 'Modest'),
              _Preference(label: 'Capsule wardrobe'),
              _Preference(label: 'Sage accents'),
            ],
          ),
          const SizedBox(height: 24),
          _sectionHeader('Saved looks', 'View all'),
          const SizedBox(height: 12),
          SizedBox(
            height: 218,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: savedLooks.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 160,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: OutfitCard(outfit: savedLooks[index]),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          _sectionHeader('Style gallery', 'Pinterest mood'),
          const SizedBox(height: 12),
          const _PinterestGallery(colors: wardrobe),
          const SizedBox(height: 24),
          _sectionHeader('Wardrobe grid', '9 items'),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 9,
              mainAxisSpacing: 9,
              childAspectRatio: 0.9,
            ),
            itemCount: wardrobe.length,
            itemBuilder: (context, i) {
              return Container(
                decoration: BoxDecoration(
                  color: wardrobe[i],
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: _beige.withValues(alpha: 0.8)),
                ),
                child: Center(
                  child: Icon(
                    i.isEven
                        ? Icons.checkroom_rounded
                        : Icons.shopping_bag_rounded,
                    color: _card.withValues(alpha: 0.82),
                    size: 30,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _text,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            color: _brown,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _stat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: _text,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(label, style: const TextStyle(color: _muted, fontSize: 12)),
      ],
    );
  }

  Widget _divider() => Container(height: 34, width: 1, color: _beige);
}

class _PinterestGallery extends StatelessWidget {
  const _PinterestGallery({required this.colors});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: _GalleryColumn(
                colors: colors.take(4).toList(), tallFirst: true)),
        const SizedBox(width: 9),
        Expanded(
            child: _GalleryColumn(colors: colors.skip(4).take(5).toList())),
      ],
    );
  }
}

class _GalleryColumn extends StatelessWidget {
  const _GalleryColumn({required this.colors, this.tallFirst = false});

  final List<Color> colors;
  final bool tallFirst;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(colors.length, (index) {
        final height = (tallFirst && index == 0) || (!tallFirst && index == 1)
            ? 170.0
            : 118.0;
        return Container(
          height: height,
          margin: const EdgeInsets.only(bottom: 9),
          decoration: BoxDecoration(
            color: colors[index],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _beige),
          ),
          child: Center(
            child: Icon(Icons.checkroom_rounded,
                color: _card.withValues(alpha: 0.8), size: 38),
          ),
        );
      }),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({required this.label, this.filled = false});

  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: filled ? _brown : _card,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: filled ? _brown : _beige),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: filled ? _card : _brown,
            fontWeight: FontWeight.w900,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _Preference extends StatelessWidget {
  const _Preference({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _sage.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: _sage.withValues(alpha: 0.22)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _text,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
