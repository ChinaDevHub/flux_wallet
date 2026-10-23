import 'package:flux_wallet/features/debts/domain/entities/debt_details.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/domain/repositories/debt_repository.dart';
import 'package:flux_wallet/features/debts/domain/usecases/validate_debt.dart';

/// Correct who, when it is due and the note of a debt. The money is not
/// editable: to change the amount, delete the debt and enter it again.
/// Who, until when, and a note: what the edit sheet collects.
typedef DebtDetailsInput = ({String person, DateTime? dueDate, String? note});

class EditDebt {
  const EditDebt(this._debts, this._clock);

  final DebtRepository _debts;
  final DateTime Function() _clock;

  Future<void> call(DebtSummary summary, DebtDetailsInput d) {
    final note = d.note?.trim() ?? '';
    final edited = summary.debt.withDetails(
      person: d.person.trim(),
      dueDate: d.dueDate,
      note: note.isEmpty ? null : note,
    );
    validateDebt(edited, _clock());
    return _debts.updateDetails(edited);
  }
}
