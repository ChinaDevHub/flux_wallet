import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/manage/action_buttons.dart';
import 'package:flux_wallet/core/widgets/muted_text.dart';
import 'package:flux_wallet/core/widgets/reveal.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/entry_actions.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/entry_info.dart';

/// What an opened entry shows: how it repeats (or where the money moved)
/// and every action as a button.
class EntryDetails extends StatelessWidget {
  const EntryDetails({
    super.key,
    required this.open,
    required this.entry,
    required this.day,
    required this.cubit,
  });

  final bool open;
  final TimelineEntry entry;
  final DateTime day;
  final TimelineCubit cubit;

  @override
  Widget build(BuildContext context) {
    final actions = entryActions(context, entry, day, cubit, extended: true);
    return Reveal(
      open: open,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            MutedText(entryInfo(entry)),
            if (actions.isNotEmpty) ActionButtons(actions: actions),
          ],
        ),
      ),
    );
  }
}
