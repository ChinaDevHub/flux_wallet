import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/day_empty_note.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/entry_tile.dart';

/// The day's lines in one card, each an accordion.
class DayEntries extends StatelessWidget {
  const DayEntries({super.key, required this.day, required this.cubit});

  final TimelineDay day;
  final TimelineCubit cubit;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final entries = day.entries;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(22),
      ),
      clipBehavior: Clip.antiAlias,
      child: entries.isEmpty
          ? DayEmptyNote(day)
          : Column(
              children: [
                for (var i = 0; i < entries.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 1,
                      indent: 14,
                      endIndent: 14,
                      color: c.divider,
                    ),
                  EntryTile(
                    key: ValueKey('${day.date}-$i-${entries[i].title}'),
                    entry: entries[i],
                    day: day.date,
                    cubit: cubit,
                  ),
                ],
              ],
            ),
    );
  }
}
