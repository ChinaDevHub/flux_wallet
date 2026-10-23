import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_kind.dart';

enum SaveStatus { editing, saving, done, failure }

/// Plain class (no Equatable): every emit counts, so a repeated save failure
/// still reaches the page's listener.
class NewTransactionState {
  const NewTransactionState({
    required this.date,
    this.kind = TransactionKind.expense,
    this.amountText = '',
    this.category,
    this.accounts = const [],
    this.accountId,
    this.note = '',
    this.repeat,
    this.status = SaveStatus.editing,
  });

  final TransactionKind kind;
  final String amountText;
  final String? category;
  final List<Account> accounts;
  final int? accountId;
  final DateTime date;
  final String note;
  final RecurrencePlan? repeat;
  final SaveStatus status;

  double get amount => parseMoney(amountText) ?? 0;

  bool get canSubmit =>
      amount > 0 &&
      category != null &&
      accountId != null &&
      (repeat?.isValid ?? true) &&
      status != SaveStatus.saving;
}
