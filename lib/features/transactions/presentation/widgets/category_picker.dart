import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/category_tile.dart';

/// "Kateqoriya": a grid of [categories] with [selected] highlighted.
class CategoryPicker extends StatelessWidget {
  const CategoryPicker({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  final List<String> categories;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kateqoriya',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: context.colors.text,
          ),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            for (final cat in categories)
              CategoryTile(
                category: cat,
                selected: selected == cat,
                onTap: () => onSelected(cat),
              ),
          ],
        ),
      ],
    );
  }
}
