import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_kind.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';

extension NewTransactionStateCopy on NewTransactionState {
  /// [clearCategory] / [clearRepeat] reset a field to null.
  NewTransactionState copyWith({
    TransactionKind? kind,
    String? amountText,
    String? category,
    bool clearCategory = false,
    List<Account>? accounts,
    int? accountId,
    DateTime? date,
    String? note,
    RecurrencePlan? repeat,
    bool clearRepeat = false,
    SaveStatus? status,
  }) => NewTransactionState(
    kind: kind ?? this.kind,
    amountText: amountText ?? this.amountText,
    category: clearCategory ? null : category ?? this.category,
    accounts: accounts ?? this.accounts,
    accountId: accountId ?? this.accountId,
    date: date ?? this.date,
    note: note ?? this.note,
    repeat: clearRepeat ? null : repeat ?? this.repeat,
    status: status ?? this.status,
  );
}
