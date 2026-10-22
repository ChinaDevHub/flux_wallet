import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/repositories/debt_repository.dart';

class CreateDebt {
  const CreateDebt(this._debts);

  final DebtRepository _debts;

  /// A debt I took must say when it is due: that date joins the mandatory
  /// expenses and so lowers the daily limit.
  Future<void> call(Debt debt) {
    if (debt.person.trim().isEmpty) throw ArgumentError('person');
    if (debt.amount <= 0) throw ArgumentError.value(debt.amount, 'amount');
    if (debt.direction == DebtDirection.borrowed && debt.dueDate == null) {
      throw ArgumentError('A borrowed debt needs a due date');
    }
    return _debts.add(debt);
  }
}
