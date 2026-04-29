import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'upload_screen.dart';
import 'profile_screen.dart';
import '../widgets/outfit_card.dart';
// Екран 3: Начална страница (Community Feed)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Коя категория е избрана
  String _selectedCategory = 'All';
  // Коя страница е отворена в Bottom Navigation
  int _currentIndex = 0;

  // Категориите за филтриране
  final List<String> _categories = ['All', 'Casual', 'Street', 'Elegant', 'Trending'];

  // Примерни данни за аутфити (в реалното приложение идват от база данни)
  final List<Map<String, dynamic>> _outfits = [
    {
      'user': '@sofia.style',
      'description': 'Summer casual with white linen',
      'likes': 124,
      'rating': 4.5,
      'color': Color(0xFF3D5A80),
    },
    {
      'user': '@mia.looks',
      'description': 'Street style black on black',
      'likes': 89,
      'rating': 4.0,
      'color': Color(0xFF4A4A6A),
    },
    {
      'user': '@ana.fashion',
      'description': 'Elegant evening outfit',
      'likes': 215,
      'rating': 5.0,
      'color': Color(0xFF5C4033),
    },
    {
      'user': '@lena.style',
      'description': 'Minimalist beige aesthetic',
      'likes': 67,
      'rating': 3.5,
      'color': Color(0xFF6B5B45),
    },
    {
      'user': '@iva.outfits',
      'description': 'Cozy autumn vibes',
      'likes': 143,
      'rating': 4.0,
      'color': Color(0xFF4E3B31),
    },
    {
      'user': '@marta.wear',
      'description': 'Office chic look',
      'likes': 98,
      'rating': 4.5,
      'color': Color(0xFF2C4A52),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),

      // Горна лента
      appBar: AppBar(
        backgroundColor: const Color(0xFF12122A),
        elevation: 0,
        title: const Text(
          'Modesta',
          style: TextStyle(
            color: Color(0xFFE8D5B7),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          // Бутон за добавяне на аутфит
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Color(0xFFE8D5B7)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploadScreen()),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // Категории (хоризонтален скрол)
          SizedBox(
            height: 56,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedCategory == _categories[index];
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = _categories[index]),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFE8D5B7)
                          : const Color(0xFF2D2D44),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        _categories[index],
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF1A1A2E)
                              : Colors.white,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Списък с аутфити
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,      // 2 колони
                childAspectRatio: 0.7,  // Пропорции на картата
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _outfits.length,
              itemBuilder: (context, index) {
                return OutfitCard(outfit: _outfits[index]);
              },
            ),
          ),
        ],
      ),

      // Долна навигация
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF12122A),
        selectedItemColor: const Color(0xFFE8D5B7),
        unselectedItemColor: const Color(0xFF555555),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _currentIndex = index);
          // Навигация към другите екрани
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
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