import 'package:flutter/material.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day_empty_note.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day_entry_line.dart';

/// The lines of one day; only planned (virtual) ones react to taps.
class DayEntries extends StatelessWidget {
  const DayEntries({super.key, required this.day, required this.onTapEntry});

  final TimelineDay day;
  final ValueChanged<TimelineEntry> onTapEntry;

  @override
  Widget build(BuildContext context) {
    if (day.entries.isEmpty) return DayEmptyNote(day);
    return Column(
      children: [
        for (final e in day.entries)
          DayEntryLine(
            entry: e,
            onTap: e.isEditable ? () => onTapEntry(e) : null,
          ),
      ],
    );
  }
}
