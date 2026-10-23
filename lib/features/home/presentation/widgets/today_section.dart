import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_list_x.dart';
import 'package:flux_wallet/features/home/presentation/widgets/section_title.dart';
import 'package:flux_wallet/features/home/presentation/widgets/today_tiles.dart';

class TodaySection extends StatelessWidget {
  const TodaySection({super.key, required this.snapshot});

  final HomeSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final tiles = todayTiles(context, snapshot);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          'Bu gün',
          trailing: Text(
            'Cəmi: ${formatAzn(-snapshot.todayTransactions.totalExpense)}',
            style: TextStyle(fontSize: 12, color: c.textMuted),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(22),
          ),
          child: tiles.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Bu gün hələ xərc yoxdur',
                    style: TextStyle(color: c.textMuted),
                  ),
                )
              : Column(children: tiles),
        ),
      ],
    );
  }
}
