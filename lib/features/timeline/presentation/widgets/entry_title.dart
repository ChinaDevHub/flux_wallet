import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/entry_label.dart';

class EntryTitle extends StatelessWidget {
  const EntryTitle(this.entry, {super.key});

  final TimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    return Text(
      entry.label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.w800, color: context.colors.text),
    );
  }
}
