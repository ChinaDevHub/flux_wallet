import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/category_style.dart';

class ApprovalCategoryChip extends StatelessWidget {
  const ApprovalCategoryChip({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final String category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = CategoryStyle.of(category);
    return ChoiceChip(
      avatar: Icon(style.icon, size: 16, color: style.color),
      label: Text(style.label),
      selected: selected,
      showCheckmark: false,
      onSelected: (_) => onTap(),
    );
  }
}
