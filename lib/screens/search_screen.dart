import 'package:flutter/material.dart';
import '../widgets/outfit_card.dart';

const Color _card = Color(0xFFFFFDF7);
const Color _text = Color(0xFF3A2A1F);
const Color _brown = Color(0xFFA47551);
const Color _beige = Color(0xFFE8DCC8);
const Color _sage = Color(0xFF8FAE8B);
const Color _muted = Color(0xFF8C7A6B);

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';
  String _filter = 'Category';

  final List<String> _filters = const ['Category', 'Color', 'Season', 'Style'];

  final List<Map<String, dynamic>> _results = const [
    {
      'title': 'Cream blazer capsule',
      'user': '@modesta.edit',
      'color': Color(0xFFE8DCC8),
      'tags': ['workwear', 'cream'],
      'likes': '7.8k',
    },
    {
      'title': 'Sage scarf styling',
      'user': '@lena.style',
      'color': Color(0xFFD6E4CF),
      'tags': ['sage', 'minimal'],
      'likes': '4.1k',
    },
    {
      'title': 'Camel dinner look',
      'user': '@mira.looks',
      'color': Color(0xFFD9C8AE),
      'tags': ['camel', 'evening'],
      'likes': '9.4k',
    },
    {
      'title': 'Ivory weekend set',
      'user': '@sofia.style',
      'color': Color(0xFFFFFDF7),
      'tags': ['casual', 'ivory'],
      'likes': '6.6k',
    },
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
        children: [
          Container(
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _beige),
              boxShadow: [
                BoxShadow(
                  color: _brown.withValues(alpha: 0.04),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _query = v),
              style: const TextStyle(color: _text),
              decoration: InputDecoration(
                hintText: 'Search outfits, creators, colors...',
                hintStyle: const TextStyle(color: _muted, fontSize: 13),
                prefixIcon: const Icon(Icons.search_rounded, color: _brown),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded,
                            color: _muted, size: 18),
                        onPressed: () {
                          _searchCtrl.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final selected = filter == _filter;
                return GestureDetector(
                  onTap: () => setState(() => _filter = filter),
                  child: Container(
                    margin: const EdgeInsets.only(right: 9),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: selected ? _brown : _card,
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: _beige),
                    ),
                    child: Center(
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: selected ? _card : _text,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Recommended results',
            style: TextStyle(
              color: _text,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Filtered by category, color, season, and style preference.',
            style: TextStyle(color: _muted, fontSize: 12),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _results.length,
            itemBuilder: (context, index) =>
                OutfitCard(outfit: _results[index]),
          ),
          const SizedBox(height: 22),
          const Text(
            'Popular filters',
            style: TextStyle(
              color: _text,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _FilterPill(label: 'Autumn neutrals'),
              _FilterPill(label: 'Modest evening'),
              _FilterPill(label: 'Office capsule'),
              _FilterPill(label: 'Sage accessories'),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: _sage.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: _sage.withValues(alpha: 0.22)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _text,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
