import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/core/widgets/sheet_heading.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/month_chips.dart';

/// Pick the months a rule pauses in; pops with the chosen set.
class MonthPickerSheet extends StatefulWidget {
  const MonthPickerSheet({super.key, required this.initial});

  final Set<int> initial;

  @override
  State<MonthPickerSheet> createState() => _MonthPickerSheetState();
}

class _MonthPickerSheetState extends State<MonthPickerSheet> {
  late final Set<int> _months = widget.initial.toSet();

  void _toggle(int m) =>
      setState(() => _months.contains(m) ? _months.remove(m) : _months.add(m));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          const SheetHeading(
            'İstisna aylar',
            description:
                'Seçilən aylarda bu xərc planlanmayacaq (məsələn, məzuniyyət).',
          ),
          MonthChips(selected: _months, onToggle: _toggle),
          PrimaryButton(
            label: 'Hazır',
            onPressed: () => Navigator.pop(context, _months),
          ),
        ],
      ),
    );
  }
}
