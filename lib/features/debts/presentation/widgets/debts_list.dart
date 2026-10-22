import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';

/// Open debts, then a muted "Bağlanıb" group, or an empty hint.
class DebtsList extends StatelessWidget {
  const DebtsList({
    super.key,
    required this.open,
    required this.closed,
    required this.card,
  });

  final List<DebtSummary> open, closed;
  final Widget Function(DebtSummary) card;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (open.isEmpty && closed.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Center(
              child: Text(
                'Hələ borc yoxdur',
                style: TextStyle(color: c.textMuted),
              ),
            ),
          ),
        ...open.map(card),
        if (closed.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 10),
            child: Text(
              'Bağlanıb',
              style: TextStyle(fontWeight: FontWeight.w800, color: c.textMuted),
            ),
          ),
          Opacity(
            opacity: 0.6,
            child: Column(children: closed.map(card).toList()),
          ),
        ],
      ],
    );
  }
}
