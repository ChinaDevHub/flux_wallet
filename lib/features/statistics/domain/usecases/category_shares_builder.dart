import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/statistics/domain/entities/category_share.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// Share of each category in [month]'s expenses, biggest first. Categories
/// beyond [maxSlices] - 1 are folded into "other", which always comes last.
List<CategoryShare> categoryShares(
  List<Transaction> all,
  DateTime month, {
  int maxSlices = 6,
}) {
  final totals = <String, double>{};
  for (final t in all) {
    if (t.type != TxType.expense || monthStart(t.date) != month) continue;
    totals[t.category] = (totals[t.category] ?? 0) + t.amount;
  }
  final grand = totals.values.fold(0.0, (s, v) => s + v);
  if (grand == 0) return const [];
  final named = totals.entries.where((e) => e.key != 'other').toList()
    ..sort((a, b) {
      final byAmount = b.value.compareTo(a.value);
      return byAmount != 0 ? byAmount : a.key.compareTo(b.key);
    });
  final head = named.take(maxSlices - 1).toList();
  final folded = named.skip(maxSlices - 1).fold(0.0, (s, e) => s + e.value);
  final other = (totals['other'] ?? 0) + folded;
  return [
    for (final e in head) _share(e.key, e.value, grand),
    if (other > 0) _share('other', other, grand),
  ];
}

CategoryShare _share(String category, double amount, double grand) =>
    CategoryShare(
      category: category,
      amount: amount,
      percent: amount / grand * 100,
    );
