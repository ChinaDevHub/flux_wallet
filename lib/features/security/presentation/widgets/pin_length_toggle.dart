import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_segmented.dart';
import 'package:flux_wallet/features/security/domain/entities/pin_policy.dart';

/// 4 or 6 digits, chosen while picking a new PIN.
class PinLengthToggle extends StatelessWidget {
  const PinLengthToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: AdaptiveSegmented<int>(
        selected: selected,
        onChanged: onChanged,
        options: {for (final n in PinPolicy.lengths) n: '$n rəqəm'},
      ),
    );
  }
}
