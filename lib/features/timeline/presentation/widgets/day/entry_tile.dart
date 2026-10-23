import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/manage/swipe_actions.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/entry_actions.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/entry_details.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/entry_row.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/entry_label.dart';

/// A day line as an accordion; swiping it offers the same actions.
class EntryTile extends StatefulWidget {
  const EntryTile({
    super.key,
    required this.entry,
    required this.day,
    required this.cubit,
  });

  final TimelineEntry entry;
  final DateTime day;
  final TimelineCubit cubit;

  @override
  State<EntryTile> createState() => _EntryTileState();
}

class _EntryTileState extends State<EntryTile> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final w = widget;
    final e = w.entry;
    return SwipeActions(
      title: e.label,
      actions: entryActions(context, e, w.day, w.cubit),
      child: Column(
        children: [
          EntryRow(
            entry: e,
            open: _open,
            onTap: () => setState(() => _open = !_open),
            onSwitch: (on) => w.cubit.setSkipped(e.rule!, w.day, !on),
          ),
          EntryDetails(open: _open, entry: e, day: w.day, cubit: w.cubit),
        ],
      ),
    );
  }
}
