import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'profile_screen.dart';
import 'upload_screen.dart';
import '../widgets/outfit_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All', 'Casual', 'Street', 'Elegant', 'Trendy'
  ];

  final List<Map<String, dynamic>> _outfits = [
    {'user': '@sofia.style', 'label': 'Summer vibes', 'color': Color(0xFFD6E4CF), 'liked': false},
    {'user': '@mira.looks', 'label': 'Street style', 'color': Color(0xFFE8DDD0), 'liked': false},
    {'user': '@ana.fashion', 'label': 'Elegant night', 'color': Color(0xFFCDD9E5), 'liked': false},
    {'user': '@lena.style', 'label': 'Beige aesthetic', 'color': Color(0xFFEDE3D5), 'liked': false},
    {'user': '@nora.fit', 'label': 'Cozy layers', 'color': Color(0xFFD9D4E7), 'liked': false},
    {'user': '@zara.mood', 'label': 'Minimal look', 'color': Color(0xFFE2EAD8), 'liked': false},
  ];

  void _toggleLike(int index) {
    setState(() {
      _outfits[index]['liked'] = !_outfits[index]['liked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      _buildFeed(),
      const SearchScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5EB),
      body: screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UploadScreen()),
          );
        },
        backgroundColor: const Color(0xFF8DAA81),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, 'Home', 0),
              _navItem(Icons.search_rounded, 'Search', 1),
              const SizedBox(width: 48),
              _navItem(Icons.person_rounded, 'Profile', 2),
              _navItem(Icons.grid_view_rounded, 'More', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool active = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index < 3 ? index : _currentIndex),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: active ? const Color(0xFF8DAA81) : Colors.grey.shade400,
              size: 24),
          Text(label,
              style: TextStyle(
                  fontSize: 10,
                  color: active ? const Color(0xFF8DAA81) : Colors.grey.shade400)),
        ],
      ),
    );
  }

  Widget _buildFeed() {
    return SafeArea(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu_rounded, color: Color(0xFF3D3D3D)),
                const Text(
                  'Modesta',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8DAA81),
                    letterSpacing: 1.5,
                  ),
                ),
                Stack(
                  children: [
                    const Icon(Icons.notifications_none_rounded, color: Color(0xFF3D3D3D)),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8DAA81),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          // Categories
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, i) {
                final bool selected = _selectedCategory == _categories[i];
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = _categories[i]),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? const Color(0xFF8DAA81) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected ? const Color(0xFF8DAA81) : Colors.grey.shade200,
                      ),
                    ),
                    child: Text(
                      _categories[i],
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.grey.shade600,
                        fontSize: 13,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: _outfits.length,
              itemBuilder: (context, i) {
                return OutfitCard(
                  user: _outfits[i]['user'],
                  label: _outfits[i]['label'],
                  color: _outfits[i]['color'],
                  liked: _outfits[i]['liked'],
                  onLike: () => _toggleLike(i),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
