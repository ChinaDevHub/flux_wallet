import 'package:flutter/material.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';

class LimitStatusChip extends StatelessWidget {
  const LimitStatusChip(this.snapshot, {super.key});

  final HomeSnapshot snapshot;

  String get _label => snapshot.limit.hasShortfall
      ? 'Çatışmazlıq'
      : snapshot.remainingToday < 0
      ? 'Limit aşılıb'
      : 'Normadadır';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
