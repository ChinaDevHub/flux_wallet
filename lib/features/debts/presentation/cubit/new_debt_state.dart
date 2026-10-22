import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';

enum DebtSaveStatus { editing, saving, done, failure }

/// Plain class: every emit counts, so a repeated failure still notifies.
class NewDebtState {
  const NewDebtState({
    required this.date,
    this.direction = DebtDirection.borrowed,
    this.person = '',
    this.amountText = '',
    this.dueDate,
    this.note = '',
    this.accounts = const [],
    this.accountId,
    this.status = DebtSaveStatus.editing,
  });

  final DebtDirection direction;
  final String person, amountText, note;

  /// When the money changed hands (today or earlier).
  final DateTime date;
  final DateTime? dueDate;
  final List<Account> accounts;
  final int? accountId;
  final DebtSaveStatus status;

  double get amount => parseMoney(amountText) ?? 0;

  bool get needsDueDate => direction == DebtDirection.borrowed;

  Account? get account => accounts.where((a) => a.id == accountId).firstOrNull;

  bool get canSubmit =>
      person.trim().isNotEmpty &&
      amount > 0 &&
      accountId != null &&
      (!needsDueDate || dueDate != null) &&
      status != DebtSaveStatus.saving;
}
