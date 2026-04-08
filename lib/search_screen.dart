import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2F2F2F),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search outfits...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(Icons.search, color: Color(0xFF7A8F5C)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              Expanded(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 380),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBD9CB),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Women text
                        const Positioned(
                          left: 22,
                          top: 22,
                          child: Text(
                            'Women',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF3D3D3D),
                            ),
                          ),
                        ),

                        // Men text
                        const Positioned(
                          right: 22,
                          top: 22,
                          child: Text(
                            'Men',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF3D3D3D),
                            ),
                          ),
                        ),

                        // Closet body
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(18, 60, 18, 18),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5E9DF),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: const Color(0xFFD8C5B6),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color: Color(0xFFD8C5B6),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                      child: const Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.checkroom,
                                              size: 55, color: Color(0xFF7A8F5C)),
                                          SizedBox(height: 12),
                                          Icon(Icons.dry_cleaning,
                                              size: 50, color: Color(0xFFC9A27E)),
                                          SizedBox(height: 12),
                                          Icon(Icons.shopping_bag_outlined,
                                              size: 45, color: Color(0xFF8A8A8A)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.checkroom,
                                            size: 55, color: Color(0xFFC9A27E)),
                                        SizedBox(height: 12),
                                        Icon(Icons.iron,
                                            size: 45, color: Color(0xFF7A8F5C)),
                                        SizedBox(height: 12),
                                        Icon(Icons.backpack_outlined,
                                            size: 45, color: Color(0xFF8A8A8A)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Middle hanger / handle
                        Positioned(
                          top: 88,
                          child: Column(
                            children: [
                              Container(
                                width: 6,
                                height: 24,
                                color: const Color(0xFF8B6D57),
                              ),
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8B6D57),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                child: const Icon(
                                  Icons.circle_outlined,
                                  size: 18,
                                  color: Color(0xFFF7F1EB),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}