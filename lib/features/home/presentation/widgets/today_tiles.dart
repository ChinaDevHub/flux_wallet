import 'package:flutter/material.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/domain/entities/transaction.dart';
import 'package:flux_wallet/features/home/presentation/widgets/category_style.dart';
import 'package:flux_wallet/features/home/presentation/widgets/today_tile.dart';

/// Planned (automatic) items first, then today's real transactions.
List<Widget> todayTiles(HomeSnapshot s) => [
  for (final p in s.todayPlans)
    TodayTile(
      category: p.rule.category,
      title: p.rule.title,
      subtitle: 'Avtomatik plan',
      signedAmount: -p.rule.amount,
      planned: true,
    ),
  for (final t in s.todayTransactions)
    TodayTile(
      category: t.category,
      title: t.note ?? CategoryStyle.of(t.category).label,
      subtitle: t.source == TxSource.notification ? 'Bildirişdən' : 'Əl ilə',
      signedAmount: t.signedAmount,
    ),
];
