import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/approval_category_chip.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_categories.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// "Kateqoriyanı seç": the same categories as the manual form.
class ApprovalCategoryChips extends StatelessWidget {
  const ApprovalCategoryChips({
    super.key,
    required this.type,
    required this.selected,
    required this.onSelected,
  });

  final TxType type;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final items = type == TxType.income ? incomeCategories : expenseCategories;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Kateqoriyanı seç',
          style: TextStyle(fontSize: 12, color: c.textMuted),
        ),
        Wrap(
          spacing: 8,
          children: [
            for (final cat in items)
              ApprovalCategoryChip(
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
