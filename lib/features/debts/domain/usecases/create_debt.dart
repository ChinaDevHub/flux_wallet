import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/utils/day_stamp.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/repositories/debt_repository.dart';
import 'package:flux_wallet/features/debts/domain/usecases/validate_debt.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// Borrowing puts the money into [accountId] now; lending takes it out. The
/// debt may be dated in the past (it was forgotten), never in the future.
class CreateDebt {
  const CreateDebt(this._debts, this._clock);

  final DebtRepository _debts;
  final Clock _clock;

  Future<void> call(Debt debt, {required int accountId}) {
    final now = _clock();
    validateDebt(debt, now);
    final at = stampDay(debt.createdAt, now);
    final borrowed = debt.direction == DebtDirection.borrowed;
    return _debts.add(
      debt.withCreatedAt(at),
      Transaction(
        amount: debt.amount,
        type: borrowed ? TxType.income : TxType.expense,
        category: 'debt',
        accountId: accountId,
        date: at,
        note: debt.person,
      ),
    );
  }
}
