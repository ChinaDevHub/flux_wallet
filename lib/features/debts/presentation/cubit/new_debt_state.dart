import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';

enum DebtSaveStatus { editing, saving, done, failure }

/// Plain class: every emit counts, so a repeated failure still notifies.
class NewDebtState {
  const NewDebtState({
    this.direction = DebtDirection.borrowed,
    this.person = '',
    this.amountText = '',
    this.dueDate,
    this.note = '',
    this.status = DebtSaveStatus.editing,
  });

  final DebtDirection direction;
  final String person, amountText, note;
  final DateTime? dueDate;
  final DebtSaveStatus status;

  double get amount => parseMoney(amountText) ?? 0;

  bool get needsDueDate => direction == DebtDirection.borrowed;

  bool get canSubmit =>
      person.trim().isNotEmpty &&
      amount > 0 &&
      (!needsDueDate || dueDate != null) &&
      status != DebtSaveStatus.saving;

  NewDebtState copyWith({
    DebtDirection? direction,
    String? person,
    String? amountText,
    String? note,
    DateTime? dueDate,
    bool clearDue = false,
    DebtSaveStatus? status,
  }) => NewDebtState(
    direction: direction ?? this.direction,
    person: person ?? this.person,
    amountText: amountText ?? this.amountText,
    dueDate: clearDue ? null : dueDate ?? this.dueDate,
    note: note ?? this.note,
    status: status ?? this.status,
  );
}
