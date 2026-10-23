import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/app_text_field.dart';
import 'package:flux_wallet/core/widgets/field_kind.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/core/widgets/sheet_body.dart';
import 'package:flux_wallet/core/widgets/sheet_heading.dart';
import 'package:flux_wallet/core/widgets/sheet_text_button.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/budget_texts.dart';

/// The daily cap sheet's content.
class DailyCapForm extends StatelessWidget {
  const DailyCapForm({
    super.key,
    required this.controller,
    required this.amount,
    required this.canClear,
    required this.onChanged,
    required this.onSave,
    required this.onClear,
  });

  final TextEditingController controller;
  final double? amount;
  final bool canClear;
  final VoidCallback onChanged, onSave, onClear;

  @override
  Widget build(BuildContext context) {
    return SheetBody(
      spacing: 14,
      children: [
        const SheetHeading('Gündəlik xərc limiti', description: dailyCapHelp),
        AppTextField(
          controller: controller,
          label: 'Məbləğ (₼)',
          kind: FieldKind.decimal,
          onChanged: (_) => onChanged(),
        ),
        PrimaryButton(
          label: 'Yadda saxla',
          onPressed: amount == null ? null : () => closeThen(context, onSave),
        ),
        if (canClear) SheetTextButton('Limiti sil', onTap: onClear),
      ],
    );
  }
}
