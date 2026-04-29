import 'package:flutter/material.dart';

// Widget за показване на един аутфит в списъка
class OutfitCard extends StatefulWidget {
  final Map<String, dynamic> outfit;

  const OutfitCard({super.key, required this.outfit});

  @override
  State<OutfitCard> createState() => _OutfitCardState();
}

class _OutfitCardState extends State<OutfitCard> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D44),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Снимка на аутфита (placeholder с цвят)
          Expanded(
            child: Container(
              width: double.infinity,
              color: widget.outfit['color'],
              child: const Icon(
                Icons.checkroom,
                size: 60,
                color: Colors.white30,
              ),
            ),
          ),

          // Информация под снимката
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Ред с потребител и харесване
                Row(
                  children: [
                    // Малка иконка за потребител
                    const CircleAvatar(
                      radius: 12,
                      backgroundColor: Color(0xFF4A4A6A),
                      child: Icon(Icons.person, size: 14, color: Colors.white),
                    ),
                    const SizedBox(width: 6),

                    // Потребителско име
                    Expanded(
                      child: Text(
                        widget.outfit['user'],
                        style: const TextStyle(
                          color: Color(0xFFE8D5B7),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Бутон харесване
                    GestureDetector(
                      onTap: () => setState(() => _isLiked = !_isLiked),
                      child: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        size: 16,
                        color: _isLiked ? Colors.redAccent : const Color(0xFF888888),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Описание
                Text(
                  widget.outfit['description'],
                  style: const TextStyle(
                    color: Color(0xFFAAAAAA),
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // Звезди за рейтинг
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      i < widget.outfit['rating'].floor()
                          ? Icons.star
                          : Icons.star_border,
                      size: 12,
                      color: const Color(0xFFE8D5B7),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}