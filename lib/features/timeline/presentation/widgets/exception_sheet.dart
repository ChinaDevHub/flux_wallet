import 'package:flutter/material.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day_off_row.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/entry_label.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/exception_options.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/sheet_cancel_button.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/sheet_heading.dart';

/// Popup for one planned entry: this day only, this day onwards, or a day off.
class ExceptionSheet extends StatelessWidget {
  const ExceptionSheet({
    super.key,
    required this.entry,
    required this.dayOff,
    required this.onOnce,
    required this.onFromHere,
    required this.onDayOffChanged,
  });

  final TimelineEntry entry;
  final bool dayOff;
  final VoidCallback onOnce, onFromHere;
  final ValueChanged<bool> onDayOffChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          SheetHeading(
            '${entry.label} ${entry.isIncome ? 'gəlirini' : 'xərcini'} sil',
            description:
                'Bu əməliyyat təkrarlanan qaydaya aiddir. '
                'Hansı qaydanı tətbiq etmək istəyirsiniz?',
          ),
          ExceptionOptions(onOnce: onOnce, onFromHere: onFromHere),
          DayOffRow(initial: dayOff, onChanged: onDayOffChanged),
          const SheetCancelButton('Ləğv et'),
        ],
      ),
    );
  }
}
