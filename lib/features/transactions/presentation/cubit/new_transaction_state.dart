import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_kind.dart';

enum SaveStatus { editing, saving, done, failure }

/// Plain class (no Equatable): every emit counts.
class NewTransactionState {
  const NewTransactionState({
    required this.date,
    required this.today,
    this.kind = TransactionKind.expense,
    this.amountText = '',
    this.category,
    this.accounts = const [],
    this.accountId,
    this.note = '',
    this.repeat,
    this.status = SaveStatus.editing,
    this.editing,
  });

  final TransactionKind kind;
  final String amountText, note;
  final String? category;
  final List<Account> accounts;
  final int? accountId;
  final DateTime date;
  final RecurrencePlan? repeat;
  final SaveStatus status;

  final DateTime today;

  final Transaction? editing;

  /// A day that has not come yet is planned, not recorded.
  bool get isPlan => date.isAfter(today);
  bool get isEditing => editing != null;

  double get amount => parseMoney(amountText) ?? 0;

  bool get canSubmit =>
      amount > 0 &&
      category != null &&
      accountId != null &&
      (repeat?.isValid ?? true) &&
      status != SaveStatus.saving;
}
