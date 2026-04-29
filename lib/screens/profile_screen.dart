import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), backgroundColor: const Color(0xFF8DAA81)),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(radius: 50, backgroundColor: Color(0xFF8DAA81), child: Icon(Icons.person, size: 50, color: Colors.white)),
          const Text("@milena_style", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: const Text("Edit Profile")),
          const Divider(height: 40),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: 9,
              itemBuilder: (context, i) => Container(margin: const EdgeInsets.all(2), color: Colors.grey[300]),
            ),
          )
        ],
      ),
    );
  }
}