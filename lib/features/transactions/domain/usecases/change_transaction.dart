import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/utils/day_stamp.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

/// Fixing a mistake: edit or remove a transaction. Its balance effect is
/// undone first, so the accounts always match the list.
class ChangeTransaction {
  const ChangeTransaction(this._transactions, this._clock);

  final TransactionRepository _transactions;
  final Clock _clock;

  /// Debt movements are managed from the debt itself.
  static bool canChange(Transaction t) => t.id != null && t.debtId == null;

  Future<void> update(Transaction old, Transaction edited) {
    if (!canChange(old) || edited.amount <= 0) {
      throw ArgumentError('This transaction cannot be changed');
    }
    // Same day: keep the original time, so the order within the day holds.
    final sameDay = dateOnly(edited.date) == dateOnly(old.date);
    final date = sameDay ? old.date : stampDay(edited.date, _clock());
    return _transactions.update(
      Transaction(
        id: old.id,
        amount: edited.amount,
        type: edited.type,
        category: edited.category,
        accountId: edited.accountId,
        date: date,
        source: old.source,
        note: edited.note,
      ),
    );
  }

  Future<void> remove(Transaction t) {
    if (!canChange(t)) {
      throw ArgumentError('This transaction cannot be removed');
    }
    return _transactions.delete(t.id!);
  }
}
