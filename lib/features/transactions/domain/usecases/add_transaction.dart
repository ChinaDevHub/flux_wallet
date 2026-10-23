import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/utils/day_stamp.dart';
import 'package:flux_wallet/features/rules/domain/usecases/create_rule_from_transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/new_transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

/// Records money that moved (today or earlier), or plans money that will
/// move (a later day): the future is never stored as a transaction.
class AddTransaction {
  const AddTransaction(this._transactions, this._createRule, this._clock);

  final TransactionRepository _transactions;
  final CreateRuleFromTransaction _createRule;
  final Clock _clock;

  Future<void> call(NewTransaction n) async {
    if (n.amount <= 0) throw ArgumentError.value(n.amount, 'amount');
    if (dateOnly(n.date).isAfter(dateOnly(_clock()))) {
      return _createRule.planAhead(n, n.repeat);
    }
    await _transactions.add(
      Transaction(
        amount: n.amount,
        type: n.kind.type,
        category: n.category,
        accountId: n.accountId,
        date: stampDay(n.date, _clock()),
        note: n.note,
      ),
    );
    final repeat = n.repeat;
    if (repeat != null) await _createRule(n, repeat);
  }
}
