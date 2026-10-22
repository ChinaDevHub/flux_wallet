import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/home/domain/entities/daily_tip.dart';
import 'package:flux_wallet/features/home/presentation/widgets/tip_text.dart';

class TipCard extends StatelessWidget {
  const TipCard({super.key, required this.tip});

  final DailyTip tip;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: c.primary,
            child: Icon(StatusIcons.tip, color: c.onPrimary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Günün Tövsiyəsi',
                  style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
                ),
                const SizedBox(height: 4),
                Text(
                  tipText(tip),
                  style: TextStyle(fontSize: 13, height: 1.4, color: c.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
