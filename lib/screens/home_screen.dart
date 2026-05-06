import 'dart:math';
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

  // All outfits — each has a category tag so filtering works
  final List<Map<String, dynamic>> _allOutfits = [
    {'user': '@sofia.style', 'desc': 'Summer vibes',    'color': Color(0xFFC5D1B7), 'cat': 'Casual'},
    {'user': '@mira.looks',  'desc': 'Street style',    'color': Color(0xFFD8C4B6), 'cat': 'Street'},
    {'user': '@ana.fashion', 'desc': 'Elegant night',   'color': Color(0xFFB8C5D6), 'cat': 'Elegant'},
    {'user': '@lena.style',  'desc': 'Beige aesthetic', 'color': Color(0xFFE5D9C3), 'cat': 'Trending'},
    {'user': '@nina.fits',   'desc': 'Casual Monday',   'color': Color(0xFFD6E4CF), 'cat': 'Casual'},
    {'user': '@zara.mood',   'desc': 'Soft neutrals',   'color': Color(0xFFEAD5D5), 'cat': 'Elegant'},
    {'user': '@bia.drip',    'desc': 'Urban cool',      'color': Color(0xFFCDD9E5), 'cat': 'Street'},
    {'user': '@mia.trend',   'desc': 'Hot right now',   'color': Color(0xFFD9D4E7), 'cat': 'Trending'},
  ];

  // Currently displayed outfits (shuffled when category changes)
  late List<Map<String, dynamic>> _displayedOutfits;

  @override
  void initState() {
    super.initState();
    _displayedOutfits = List.from(_allOutfits);
  }

  void _selectCategory(String category) {
    final filtered = category == 'All'
        ? List<Map<String, dynamic>>.from(_allOutfits)
        : _allOutfits.where((o) => o['cat'] == category).toList();

    // Shuffle so it feels like fresh content
    filtered.shuffle(Random());

    setState(() {
      _selectedCategory = category;
      _displayedOutfits = filtered;
    });
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
        children: [
          // Home tab — built inside build() so it always re-renders
          Column(
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
                      onTap: () => _selectCategory(_categories[index]),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF8DAA81) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF8DAA81).withOpacity(0.3),
                          ),
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
                child: _displayedOutfits.isEmpty
                    ? Center(
                  child: Text(
                    'No outfits here yet.',
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                )
                    : GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _displayedOutfits.length,
                  itemBuilder: (context, index) =>
                      OutfitCard(outfit: _displayedOutfits[index]),
                ),
              ),
            ],
          ),
          const SearchScreen(),
          const ProfileScreen(),
        ],
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