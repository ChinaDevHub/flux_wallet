import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_payment.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/domain/repositories/debt_repository.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';

/// Paying back what I owe is an expense; getting back what I lent is income.
class RecordDebtPayment {
  const RecordDebtPayment(this._debts, this._clock);

  final DebtRepository _debts;
  final Clock _clock;

  Future<void> call(DebtSummary summary, double amount, int accountId) {
    if (amount <= 0 || amount > summary.remaining + 0.005) {
      throw ArgumentError.value(amount, 'amount');
    }
    final now = _clock();
    final borrowed = summary.debt.direction == DebtDirection.borrowed;
    return _debts.recordPayment(
      DebtPayment(debtId: summary.debt.id!, amount: amount, date: now),
      Transaction(
        amount: amount,
        type: borrowed ? TxType.expense : TxType.income,
        category: borrowed ? 'debt' : 'repayment',
        accountId: accountId,
        date: now,
        note: summary.debt.person,
      ),
    );
  }
}
