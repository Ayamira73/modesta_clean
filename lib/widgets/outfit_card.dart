import 'package:flutter/material.dart';

class OutfitCard extends StatelessWidget {
  final Map<String, dynamic> outfit;

  const OutfitCard({super.key, required this.outfit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bild-Bereich
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: outfit['color'], // Platzhalterfarbe
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: const Icon(Icons.checkroom, size: 50, color: Colors.white70),
            ),
          ),
          // Info-Bereich unten
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_circle, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(outfit['user'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    const Icon(Icons.favorite_border, size: 14, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 4),
                Text(outfit['desc'], style: const TextStyle(fontSize: 10, color: Colors.grey), maxLines: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}