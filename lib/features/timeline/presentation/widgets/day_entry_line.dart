import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/entry_amount.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/entry_subtitle.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/entry_title.dart';

/// "Avtobus -1.00 ₼" line; planned (virtual) entries are tappable.
class DayEntryLine extends StatelessWidget {
  const DayEntryLine({super.key, required this.entry, this.onTap});

  final TimelineEntry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              children: [
                Flexible(child: EntryTitle(entry)),
                EntryAmount(entry),
              ],
            ),
            if (entry.subtitle != null)
              Text(
                entry.subtitle!,
                style: TextStyle(fontSize: 11, color: context.colors.textMuted),
              ),
          ],
        ),
      ),
    );
  }
}
