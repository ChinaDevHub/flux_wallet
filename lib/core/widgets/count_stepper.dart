import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// "- 4 +" inside a pill, clamped to [min]..[max].
class CountStepper extends StatelessWidget {
  const CountStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 999,
  });

  final int value, min, max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: c.surfaceAlt,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(ActionIcons.remove, color: c.text),
            onPressed: value > min ? () => onChanged(value - 1) : null,
          ),
          SizedBox(
            width: 36,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
            ),
          ),
          IconButton(
            icon: Icon(ActionIcons.add, color: c.text),
            onPressed: value < max ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}
