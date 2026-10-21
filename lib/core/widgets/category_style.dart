import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/category_catalog.dart';

class CategoryStyle {
  const CategoryStyle(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;

  static CategoryStyle of(String category) =>
      categoryStyles[category] ?? fallbackCategoryStyle;
}
