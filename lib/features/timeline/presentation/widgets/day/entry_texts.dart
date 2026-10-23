import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/entry_label.dart';

/// Title and the small line under it; a switched-off entry is struck out.
class EntryTexts extends StatelessWidget {
  const EntryTexts(this.entry, {super.key});

  final TimelineEntry entry;

  String get _sub {
    if (entry.skipped) return 'Bu gün söndürülüb';
    if (!entry.isVirtual) return entry.account ?? '';
    return entry.rule?.category == 'debt' ? 'Borc ödənişi' : 'Planlı';
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entry.label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: entry.skipped ? c.textMuted : c.text,
            decoration: entry.skipped ? TextDecoration.lineThrough : null,
          ),
        ),
        Text(_sub, style: TextStyle(fontSize: 12, color: c.textMuted)),
      ],
    );
  }
}
