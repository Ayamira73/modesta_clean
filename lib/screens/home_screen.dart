import 'package:flutter/material.dart';
import '../widgets/outfit_card.dart';
import 'profile_screen.dart';
import 'search_screen.dart';
import 'upload_screen.dart';

const Color _bg = Color(0xFFF9F5EB);
const Color _card = Color(0xFFFFFDF7);
const Color _text = Color(0xFF3A2A1F);
const Color _brown = Color(0xFFA47551);
const Color _beige = Color(0xFFE8DCC8);
const Color _muted = Color(0xFF8C7A6B);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _posts = const [
    {
      'user': 'Sophia Lane',
      'handle': '@sofia.style',
      'avatar': Color(0xFFE8DCC8),
      'image': Color(0xFFD9C8AE),
      'title': 'Soft tailored morning',
      'desc': 'Cream blazer, satin scarf, and relaxed wide-leg trousers.',
      'tags': ['elegant', 'neutral', 'workwear'],
      'likes': '12.4k',
      'comments': '284',
    },
    {
      'user': 'Mira Noor',
      'handle': '@mira.looks',
      'avatar': Color(0xFFD8C4B6),
      'image': Color(0xFFEADFD1),
      'title': 'Modest street luxe',
      'desc': 'Longline coat with tonal layers and warm camel accessories.',
      'tags': ['street', 'camel', 'layered'],
      'likes': '8.9k',
      'comments': '156',
    },
    {
      'user': 'Lena Atelier',
      'handle': '@lena.style',
      'avatar': Color(0xFFD6E4CF),
      'image': Color(0xFFE5D9C3),
      'title': 'Dinner in ivory',
      'desc': 'A refined monochrome look with soft sage details.',
      'tags': ['evening', 'ivory', 'minimal'],
      'likes': '18.6k',
      'comments': '391',
    },
  ];

  final List<Map<String, dynamic>> _featured = const [
    {
      'title': 'Ivory trench edit',
      'color': Color(0xFFEADFD1),
      'tags': ['fall', 'classic'],
      'likes': '6.2k',
    },
    {
      'title': 'Camel knit set',
      'color': Color(0xFFD9C8AE),
      'tags': ['cozy', 'neutral'],
      'likes': '9.1k',
    },
    {
      'title': 'Sage silk scarf',
      'color': Color(0xFFD6E4CF),
      'tags': ['accent', 'soft'],
      'likes': '4.7k',
    },
  ];

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final notifications = [
          [
            'New comment on your outfit',
            'Mira loved your camel blazer styling.'
          ],
          ['Your look was saved', '28 people saved your ivory capsule look.'],
          [
            'New styling idea',
            'Try sage accessories with your cream wardrobe.'
          ],
        ];

        return Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 26),
          decoration: const BoxDecoration(
            color: _bg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _beige,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Notifications',
                style: TextStyle(
                  color: _text,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              ...notifications.map(
                (item) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _card,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: _beige),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE8DCC8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.notifications_none_rounded,
                            color: _brown),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item[0],
                              style: const TextStyle(
                                color: _text,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item[1],
                              style: const TextStyle(
                                color: _muted,
                                fontSize: 12,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final titles = ['Modesta', 'Discover', 'Upload', 'Favorites', 'Profile'];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: _currentIndex == 3
            ? const SizedBox.shrink()
            : Text(
                titles[_currentIndex],
                style: const TextStyle(
                  color: _text,
                  fontFamily: 'Georgia',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
        actions: [
          if (_currentIndex == 0) ...[
            IconButton(
              tooltip: 'Notifications',
              icon: const Icon(Icons.notifications_none_rounded, color: _text),
              onPressed: _showNotifications,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () => setState(() => _currentIndex = 4),
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: _beige,
                  child: Icon(Icons.person_rounded, color: _brown, size: 20),
                ),
              ),
            ),
          ],
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _HomeFeed(posts: _posts, featured: _featured),
          const SearchScreen(),
          const UploadScreen(isEmbedded: true),
          _FavoritesScreen(outfits: _featured),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: _card,
          border: Border(top: BorderSide(color: _beige.withValues(alpha: 0.8))),
          boxShadow: [
            BoxShadow(
              color: _brown.withValues(alpha: 0.06),
              blurRadius: 18,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: _brown,
          unselectedItemColor: _muted,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_rounded), label: 'Upload'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_rounded), label: 'Favorites'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class _HomeFeed extends StatelessWidget {
  const _HomeFeed({required this.posts, required this.featured});

  final List<Map<String, dynamic>> posts;
  final List<Map<String, dynamic>> featured;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _beige),
            boxShadow: [
              BoxShadow(
                color: _brown.withValues(alpha: 0.05),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your premium styling feed',
                      style: TextStyle(
                        color: _text,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Curated modest fashion, warm neutrals, and polished outfit ideas.',
                      style:
                          TextStyle(color: _muted, fontSize: 12, height: 1.45),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 14),
              _FashionImage(
                color: Color(0xFFE8DCC8),
                height: 92,
                width: 92,
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const _SectionTitle(title: 'Trending styles', action: 'This week'),
        const SizedBox(height: 12),
        SizedBox(
          height: 42,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _TrendChip(label: 'Quiet luxury'),
              _TrendChip(label: 'Camel layers'),
              _TrendChip(label: 'Ivory edit'),
              _TrendChip(label: 'Sage accents'),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const _SectionTitle(title: 'Featured outfits', action: 'Explore'),
        const SizedBox(height: 12),
        SizedBox(
          height: 214,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featured.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 158,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: OutfitCard(outfit: featured[index]),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const _SectionTitle(title: 'Social feed', action: 'Live'),
        const SizedBox(height: 12),
        ...posts.map((post) => _FashionPost(post: post)),
      ],
    );
  }
}

class _FashionPost extends StatelessWidget {
  const _FashionPost({required this.post});

  final Map<String, dynamic> post;

  @override
  Widget build(BuildContext context) {
    final tags = List<String>.from(post['tags']);

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _beige),
        boxShadow: [
          BoxShadow(
            color: _brown.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: post['avatar'] as Color,
                  child: const Icon(Icons.person_rounded, color: _brown),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['user'] as String,
                        style: const TextStyle(
                          color: _text,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        post['handle'] as String,
                        style: const TextStyle(color: _muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz_rounded, color: _muted),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: _FashionImage(color: post['image'] as Color, height: 285),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title'] as String,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  post['desc'] as String,
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: tags.map((tag) => _Tag(label: tag)).toList(),
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    _Action(icon: Icons.favorite_border_rounded, label: 'Like'),
                    _Action(
                        icon: Icons.chat_bubble_outline_rounded,
                        label: 'Comment'),
                    _Action(icon: Icons.ios_share_rounded, label: 'Share'),
                    Spacer(),
                    _Action(icon: Icons.bookmark_border_rounded, label: 'Save'),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${post['likes']} likes  •  ${post['comments']} comments',
                  style: const TextStyle(
                    color: _text,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoritesScreen extends StatelessWidget {
  const _FavoritesScreen({required this.outfits});

  final List<Map<String, dynamic>> outfits;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Saved Looks',
          style: TextStyle(
            color: _text,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'A polished grid of outfit ideas you can revisit and style.',
          style: TextStyle(color: _muted, fontSize: 13),
        ),
        const SizedBox(height: 18),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: outfits.length,
          itemBuilder: (context, index) => OutfitCard(outfit: outfits[index]),
        ),
      ],
    );
  }
}

class _FashionImage extends StatelessWidget {
  const _FashionImage({
    required this.color,
    required this.height,
    this.width,
  });

  final Color color;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _beige.withValues(alpha: 0.8)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: height * 0.14,
            left: 22,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: _card.withValues(alpha: 0.65),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Icon(
              Icons.checkroom_rounded,
              color: _card.withValues(alpha: 0.82),
              size: height > 120 ? 74 : 42,
            ),
          ),
          Positioned(
            right: 18,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _card.withValues(alpha: 0.78),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'outfit',
                style: TextStyle(
                  color: _brown,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.action});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
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
}

class _TrendChip extends StatelessWidget {
  const _TrendChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 9),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: _beige),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: _text, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: _beige.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        '#$label',
        style: const TextStyle(
          color: _brown,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        children: [
          Icon(icon, color: _brown, size: 20),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: _muted,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
