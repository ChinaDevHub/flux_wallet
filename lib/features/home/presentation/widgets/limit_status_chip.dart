import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/core/widgets/pulse_dot.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/domain/entities/limit_status.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_status_style.dart';

/// Today's state on the limit card, outlined in its colour: a breathing dot
/// on iOS, the state's icon on Android.
class LimitStatusChip extends StatelessWidget {
  const LimitStatusChip(this.snapshot, {super.key});

  final HomeSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final status = snapshot.status;
    final color = status.color;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.fromLTRB(8, 4, 12, 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.85), width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          context.isCupertino
              ? PulseDot(color: color, pulsing: status.pulses)
              : Icon(status.icon, size: 15, color: color),
          Text(
            status.label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
