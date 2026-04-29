import 'package:flutter/material.dart';
import '../widgets/outfit_card.dart';
import 'search_screen.dart';
import 'profile_screen.dart';
import 'upload_screen.dart'; // Важно: добавихме този импорт

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  String _activeCategory = 'All';

  final List<String> _myCategories = ['All', 'Casual', 'Street', 'Elegant', 'Trending'];

  // Примерен списък с дрехи (опростен)
  final List<Map<String, dynamic>> _myOutfits = [
    {'user': '@sofia.style', 'desc': 'Summer look', 'color': Color(0xFFC5D1B7)},
    {'user': '@mira.looks', 'desc': 'Street vibes', 'color': Color(0xFFD8C4B6)},
    {'user': '@ana.fashion', 'desc': 'Elegant dress', 'color': Color(0xFFB8C5D6)},
    {'user': '@lena.style', 'desc': 'Minimalist', 'color': Color(0xFFE5D9C3)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5EB), // Beige background

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
            'MODESTA',
            style: TextStyle(color: Color(0xFF8DAA81), fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        actions: [
          // Първи вариант за качване: Бутон горе вдясно
          IconButton(
            icon: const Icon(Icons.add_a_photo_outlined, color: Color(0xFF8DAA81)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadScreen()));
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // Списък с категории
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              itemCount: _myCategories.length,
              itemBuilder: (context, index) {
                bool isSelected = _activeCategory == _myCategories[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _activeCategory = _myCategories[index];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF8DAA81) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF8DAA81).withOpacity(0.2)),
                    ),
                    child: Center(
                      child: Text(
                        _myCategories[index],
                        style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Мрежата с аутфити
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _myOutfits.length,
              itemBuilder: (context, index) {
                return OutfitCard(outfit: _myOutfits[index]);
              },
            ),
          ),
        ],
      ),

      // Втори вариант за качване: Голям плаващ бутон "Плюс"
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8DAA81),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadScreen()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        selectedItemColor: const Color(0xFF8DAA81),
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });

          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}