import 'package:flutter/material.dart';
import 'package:flux_wallet/features/home/presentation/widgets/category_style.dart';

class CategoryIconBox extends StatelessWidget {
  const CategoryIconBox(this.category, {super.key, this.size = 42});

  final String category;
  final double size;

  @override
  Widget build(BuildContext context) {
    final style = CategoryStyle.of(category);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: style.color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(style.icon, size: size / 2.1, color: style.color),
    );
  }
}
