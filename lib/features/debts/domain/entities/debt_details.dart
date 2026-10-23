import 'package:flux_wallet/features/debts/domain/entities/debt.dart';

extension DebtDetails on Debt {
  /// The same debt with other person, due date and note; the money (amount,
  /// direction, day) is not editable.
  Debt withDetails({
    required String person,
    required DateTime? dueDate,
    required String? note,
  }) => Debt(
    id: id,
    person: person,
    amount: amount,
    direction: direction,
    createdAt: createdAt,
    dueDate: dueDate,
    note: note,
    isClosed: isClosed,
  );
}
