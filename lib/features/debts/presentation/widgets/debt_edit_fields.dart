import 'package:flutter/material.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/core/widgets/day_row.dart';
import 'package:flux_wallet/core/widgets/field_kind.dart';
import 'package:flux_wallet/core/widgets/prefilled_text_field.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';

class DebtEditFields extends StatelessWidget {
  const DebtEditFields({
    super.key,
    required this.debt,
    required this.due,
    required this.onPerson,
    required this.onDue,
    required this.onNote,
  });

  final Debt debt;
  final DateTime? due;
  final ValueChanged<String> onPerson, onNote;
  final ValueChanged<DateTime> onDue;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        PrefilledTextField(
          initial: debt.person,
          label: 'Kimlə',
          kind: FieldKind.name,
          onChanged: onPerson,
        ),
        DayRow(
          title: 'Qaytarma tarixi',
          subtitle: 'Bu tarixdə limitə təsir edir',
          date: due,
          first: dateOnly(debt.createdAt),
          last: DateTime(debt.createdAt.year + 5),
          onPicked: onDue,
        ),
        PrefilledTextField(
          initial: debt.note ?? '',
          label: 'Qeyd',
          onChanged: onNote,
        ),
      ],
    );
  }
}
