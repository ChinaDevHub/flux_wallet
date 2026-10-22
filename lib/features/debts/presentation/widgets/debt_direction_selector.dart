import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_segmented.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';

/// Borc aldım / Borc verdim.
class DebtDirectionSelector extends StatelessWidget {
  const DebtDirectionSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final DebtDirection selected;
  final ValueChanged<DebtDirection> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AdaptiveSegmented<DebtDirection>(
        selected: selected,
        onChanged: onChanged,
        options: {for (final d in DebtDirection.values) d: d.label},
      ),
    );
  }
}
