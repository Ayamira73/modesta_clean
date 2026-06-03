import 'package:flutter/material.dart';

const Color _card = Color(0xFFFFFDF7);
const Color _text = Color(0xFF3A2A1F);
const Color _brown = Color(0xFFA47551);
const Color _beige = Color(0xFFE8DCC8);
const Color _sage = Color(0xFF8FAE8B);
const Color _muted = Color(0xFF8C7A6B);

class OutfitCard extends StatelessWidget {
  final Map<String, dynamic> outfit;

  const OutfitCard({super.key, required this.outfit});

  @override
  Widget build(BuildContext context) {
    final Color color = outfit['color'] as Color? ??
        outfit['image'] as Color? ??
        const Color(0xFFE8DCC8);
    final String title = outfit['title'] as String? ??
        outfit['desc'] as String? ??
        'Curated outfit';
    final String user = outfit['user'] as String? ?? 'Modesta edit';
    final String likes = outfit['likes'] as String? ?? '4.8k';
    final String? imageUrl = outfit['imageUrl'] as String?;
    final List<String> tags = List<String>.from(
      outfit['tags'] ?? outfit['pieces'] ?? const ['neutral', 'premium'],
    );

    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _beige),
        boxShadow: [
          BoxShadow(
            color: _brown.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: imageUrl == null || imageUrl.isEmpty
                        ? Container(
                            color: color,
                            child: Center(
                              child: Icon(
                                Icons.checkroom_rounded,
                                color: _card.withValues(alpha: 0.82),
                                size: 50,
                              ),
                            ),
                          )
                        : Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: color,
                                child: Center(
                                  child: Icon(
                                    Icons.checkroom_rounded,
                                    color: _card.withValues(alpha: 0.82),
                                    size: 50,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: _card.withValues(alpha: 0.78),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.bookmark_border_rounded,
                        color: _brown,
                        size: 17,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(
                        color: _card.withValues(alpha: 0.82),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite_rounded,
                              color: _sage, size: 13),
                          const SizedBox(width: 4),
                          Text(
                            likes,
                            style: const TextStyle(
                              color: _text,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: _text,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  user,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10, color: _muted),
                ),
                const SizedBox(height: 7),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: tags.take(2).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: _beige.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 9,
                          color: _brown,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
