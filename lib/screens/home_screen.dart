import 'package:flutter/material.dart';
import '../widgets/outfit_card.dart';
import 'search_screen.dart';
import 'profile_screen.dart';
import 'upload_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Casual', 'Street', 'Elegant', 'Trending'];

  final List<Map<String, dynamic>> _outfits = [
    {'user': '@sofia.style', 'desc': 'Summer vibes',    'color': Color(0xFFC5D1B7)},
    {'user': '@mira.looks',  'desc': 'Street style',    'color': Color(0xFFD8C4B6)},
    {'user': '@ana.fashion', 'desc': 'Elegant night',   'color': Color(0xFFB8C5D6)},
    {'user': '@lena.style',  'desc': 'Beige aesthetic', 'color': Color(0xFFE5D9C3)},
    {'user': '@nina.fits',   'desc': 'Casual Monday',   'color': Color(0xFFD6E4CF)},
    {'user': '@zara.mood',   'desc': 'Soft neutrals',   'color': Color(0xFFEAD5D5)},
  ];

  // bottom navigation bar
  late final List<Widget> _pages = [
    _buildHome(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  Widget _buildHome() {
    return Column(
      children: [
        // Category filter bar
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final bool isSelected = _selectedCategory == _categories[index];
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = _categories[index]),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF8DAA81) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF8DAA81).withOpacity(0.3)),
                  ),
                  child: Center(
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Outfit grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _outfits.length,
            itemBuilder: (context, index) => OutfitCard(outfit: _outfits[index]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5EB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Modesta',
          style: TextStyle(color: Color(0xFF8DAA81), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Color(0xFF8DAA81)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploadScreen()),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF8DAA81),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}