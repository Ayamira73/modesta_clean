import 'package:flutter/material.dart';
import 'home_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String? _shape;
  String? _skin;
  String? _style;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About You"), backgroundColor: const Color(0xFF8DAA81)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Tell us your details:", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            TextField(decoration: const InputDecoration(labelText: "Height (cm)")),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Body Shape"),
              value: _shape,
              items: ['Slim', 'Athletic', 'Curvy'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) => setState(() => _shape = val),
            ),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Skin Tone"),
              value: _skin,
              items: ['Fair', 'Medium', 'Dark'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) => setState(() => _skin = val),
            ),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Style"),
              value: _style,
              items: ['Casual', 'Elegant', 'Street'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) => setState(() => _style = val),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen())),
              child: const Text("Show Outfits"),
            )
          ],
        ),
      ),
    );
  }
}