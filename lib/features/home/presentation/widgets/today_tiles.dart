import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/category_style.dart';
import 'package:flux_wallet/core/widgets/manage/swipe_actions.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/presentation/widgets/today_tile.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/transaction_row_actions.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/transaction_subtitle.dart';

/// Planned (automatic) items first, then today's real transactions, which
/// can be swiped for Redaktə et / Sil.
List<Widget> todayTiles(BuildContext context, HomeSnapshot s) => [
  for (final p in s.todayPlans)
    TodayTile(
      category: p.rule.category,
      title: p.rule.title,
      subtitle: 'Avtomatik plan',
      signedAmount: -p.rule.amount,
      planned: true,
    ),
  for (final t in s.todayTransactions)
    SwipeActions(
      title: t.note ?? CategoryStyle.of(t.category).label,
      actions: transactionRowActions(context, t),
      child: TodayTile(
        category: t.category,
        title: t.note ?? CategoryStyle.of(t.category).label,
        subtitle: transactionSubtitle(t, s.accounts),
        signedAmount: t.signedAmount,
      ),
    ),
];
