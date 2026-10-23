import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/core/widgets/sheet_body.dart';
import 'package:flux_wallet/core/widgets/sheet_heading.dart';
import 'package:flux_wallet/core/widgets/sheet_text_button.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_edit_fields.dart';

class DebtEditSheet extends StatefulWidget {
  const DebtEditSheet({super.key, required this.summary, required this.onSave});

  final DebtSummary summary;
  final void Function(String person, DateTime? due, String? note) onSave;

  @override
  State<DebtEditSheet> createState() => _DebtEditSheetState();
}

class _DebtEditSheetState extends State<DebtEditSheet> {
  late String _person = widget.summary.debt.person;
  late String _note = widget.summary.debt.note ?? '';
  late DateTime? _due = widget.summary.debt.dueDate;

  void _save() => widget.onSave(_person, _due, _note);

  @override
  Widget build(BuildContext context) {
    return SheetBody(
      children: [
        const SheetHeading(
          'Borcu redaktə et',
          description: 'Məbləği dəyişmək üçün borcu silib yenidən daxil et.',
        ),
        DebtEditFields(
          debt: widget.summary.debt,
          due: _due,
          onPerson: (v) => setState(() => _person = v),
          onDue: (d) => setState(() => _due = d),
          onNote: (v) => _note = v,
        ),
        PrimaryButton(
          label: 'Yadda saxla',
          onPressed: _person.trim().isEmpty
              ? null
              : () => closeThen(context, _save),
        ),
      ],
    );
  }
}
