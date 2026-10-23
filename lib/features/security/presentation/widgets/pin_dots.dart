import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/shake.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_dot.dart';

/// One dot per digit; the row shakes on a mistake.
class PinDots extends StatelessWidget {
  const PinDots({
    super.key,
    required this.length,
    required this.filled,
    this.error = false,
    this.shakeTick = 0,
  });

  final int length, filled, shakeTick;
  final bool error;

  @override
  Widget build(BuildContext context) {
    return Shake(
      tick: shakeTick,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 18,
        children: [
          for (var i = 0; i < length; i++)
            PinDot(filled: i < filled, error: error),
        ],
      ),
    );
  }
}
