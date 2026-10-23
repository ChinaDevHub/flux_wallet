import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_kind.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';

/// An empty form on [date] (default today), or one filled with [editing].
NewTransactionState startNewTransaction(
  DateTime today,
  DateTime? date,
  Transaction? editing,
) {
  final t = editing;
  if (t == null) {
    return NewTransactionState(today: today, date: dateOnly(date ?? today));
  }
  return NewTransactionState(
    today: today,
    editing: t,
    date: dateOnly(t.date),
    kind: t.type == TxType.income
        ? TransactionKind.income
        : TransactionKind.expense,
    amountText: formatPlain(t.amount),
    category: t.category,
    accountId: t.accountId,
    note: t.note ?? '',
  );
}
