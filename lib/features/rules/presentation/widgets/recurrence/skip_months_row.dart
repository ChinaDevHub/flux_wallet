import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/arrow_icons.dart';
import 'package:flux_wallet/core/platform/adaptive_sheet.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/form_row.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/recurrence/month_picker_sheet.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rule_schedule_label.dart';

/// "İstisna aylar": months the expense is not planned in.
class SkipMonthsRow extends StatelessWidget {
  const SkipMonthsRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final Set<int> selected;
  final ValueChanged<Set<int>> onChanged;

  Future<void> _pick(BuildContext context) async {
    final picked = await showAppSheet<Set<int>>(
      context,
      (_) => MonthPickerSheet(initial: selected),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return FormRow(
      title: 'İstisna aylar',
      subtitle: 'Bu aylarda planlanmır',
      trailing: TextButton.icon(
        onPressed: () => _pick(context),
        icon: Icon(ArrowIcons.down, color: c.text),
        iconAlignment: IconAlignment.end,
        label: Text(
          selected.isEmpty ? 'Yoxdur' : monthNames(selected),
          style: TextStyle(color: c.text),
        ),
      ),
    );
  }
}
