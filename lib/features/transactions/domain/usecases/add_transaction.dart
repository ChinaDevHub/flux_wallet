import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/usecases/create_rule_from_transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/new_transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

class AddTransaction {
  const AddTransaction(this._transactions, this._createRule, this._clock);

  final TransactionRepository _transactions;
  final CreateRuleFromTransaction _createRule;
  final Clock _clock;

  Future<void> call(NewTransaction n) async {
    if (n.amount <= 0) throw ArgumentError.value(n.amount, 'amount');
    await _transactions.add(
      Transaction(
        amount: n.amount,
        type: n.kind.type,
        category: n.category,
        accountId: n.accountId,
        date: _stamp(n.date),
        note: n.note,
      ),
    );
    final repeat = n.repeat;
    if (repeat != null) await _createRule(n, repeat);
  }

  /// Today keeps the real time; other days are pinned to noon.
  DateTime _stamp(DateTime date) {
    final day = dateOnly(date);
    return day == dateOnly(_clock())
        ? _clock()
        : day.add(const Duration(hours: 12));
  }
}
