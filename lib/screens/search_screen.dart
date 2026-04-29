import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search"), backgroundColor: const Color(0xFF8DAA81)),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: TextField(decoration: InputDecoration(hintText: "Search pullover, jeans...", prefixIcon: Icon(Icons.search))),
          ),
          const Expanded(child: Center(child: Text("Search results will appear here"))),
        ],
      ),
    );
  }
}