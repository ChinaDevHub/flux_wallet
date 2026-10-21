import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';

class EntryAmount extends StatelessWidget {
  const EntryAmount(this.entry, {super.key});

  final TimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Text(
      formatAzn(entry.signedAmount, signed: true),
      style: TextStyle(
        fontWeight: FontWeight.w800,
        color: entry.isIncome ? c.positive : c.text,
      ),
    );
  }
}
