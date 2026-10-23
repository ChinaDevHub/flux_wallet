import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// Real transactions first, then the virtual (planned) occurrences.
List<TimelineEntry> entriesFor(
  List<Transaction> transactions,
  List<PlannedPayment> plans, {
  Map<int, String> accountNames = const {},
}) => [
  for (final t in transactions)
    TimelineEntry(
      category: t.category,
      title: t.note,
      signedAmount: t.signedAmount,
      account: accountNames[t.accountId],
    ),
  for (final p in plans)
    TimelineEntry(
      category: p.rule.category,
      title: p.rule.title,
      signedAmount: p.rule.isIncome ? p.rule.amount : -p.rule.amount,
      rule: p.rule,
    ),
];
