import 'package:flutter/material.dart';

class SelectedItemsSummary<T> extends StatelessWidget {
  const SelectedItemsSummary({
    super.key,
    required this.items,
    required this.labelBuilder,
    required this.onDeleted,
    this.imageUrlBuilder,
    this.scrollDirection = Axis.horizontal,
  });

  final List<T> items;
  final String Function(T) labelBuilder;
  final String? Function(T)? imageUrlBuilder;
  final Function(T) onDeleted;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      scrollDirection: scrollDirection,
      child: Row(
        children: items.map((item) {
          final imageUrl = imageUrlBuilder?.call(item);
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Chip(
              avatar: imageUrl != null
                  ? CircleAvatar(backgroundImage: NetworkImage(imageUrl))
                  : null,
              label: Text(labelBuilder(item)),
              onDeleted: () => onDeleted(item),
            ),
          );
        }).toList(),
      ),
    );
  }
}