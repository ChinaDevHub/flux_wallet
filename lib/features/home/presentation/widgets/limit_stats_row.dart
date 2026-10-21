import 'package:flutter/material.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/home/domain/entities/daily_limit.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_stat_tile.dart';

/// Balans / Məcburi / Maaşa tiles under the hero number.
class LimitStatsRow extends StatelessWidget {
  const LimitStatsRow({super.key, required this.limit});

  final DailyLimit limit;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        LimitStatTile(label: 'Balans', value: formatAzn(limit.totalBalance)),
        LimitStatTile(label: 'Məcburi', value: formatAzn(limit.obligations)),
        LimitStatTile(label: 'Maaşa', value: '${limit.daysLeft} gün'),
      ],
    );
  }
}
