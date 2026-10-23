import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/category_icon_box.dart';
import 'package:flux_wallet/core/widgets/expand_chevron.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/entry_amount_switch.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/entry_texts.dart';

/// The always-visible line of an entry; tapping it opens or closes it, and
/// [onSwitch] turns a planned line on or off for the day.
class EntryRow extends StatelessWidget {
  const EntryRow({
    super.key,
    required this.entry,
    required this.open,
    required this.onTap,
    required this.onSwitch,
  });

  final TimelineEntry entry;
  final bool open;
  final VoidCallback onTap;
  final ValueChanged<bool> onSwitch;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          spacing: 12,
          children: [
            Opacity(
              opacity: entry.skipped ? 0.4 : 1,
              child: CategoryIconBox(entry.category),
            ),
            Expanded(child: EntryTexts(entry)),
            EntryAmountSwitch(entry: entry, onSwitch: onSwitch),
            ExpandChevron(open: open),
          ],
        ),
      ),
    );
  }
}
