import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/app_switch.dart';
import 'package:flux_wallet/core/widgets/signed_amount.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';

/// The amount and, for a planned line, the switch under it that turns the
/// line off or on for this day.
class EntryAmountSwitch extends StatelessWidget {
  const EntryAmountSwitch({
    super.key,
    required this.entry,
    required this.onSwitch,
  });

  final TimelineEntry entry;
  final ValueChanged<bool> onSwitch;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SignedAmount(entry.signedAmount, muted: entry.skipped),
        if (entry.isEditable)
          Transform.scale(
            scale: 0.78,
            alignment: Alignment.centerRight,
            child: AppSwitch(value: !entry.skipped, onChanged: onSwitch),
          ),
      ],
    );
  }
}
