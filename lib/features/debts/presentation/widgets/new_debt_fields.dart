import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/app_text_field.dart';
import 'package:flux_wallet/core/widgets/field_kind.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_account_selector.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_date_selector.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_due_selector.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_effect_note.dart';

/// Who, how much, when, through which account, until when, and a note.
class NewDebtFields extends StatelessWidget {
  const NewDebtFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NewDebtCubit>();
    return Column(
      spacing: 14,
      children: [
        AppTextField(
          label: 'Kimlə',
          kind: FieldKind.name,
          onChanged: cubit.setPerson,
        ),
        AppTextField(
          label: 'Məbləğ',
          hint: '0.00',
          kind: FieldKind.decimal,
          onChanged: cubit.setAmount,
        ),
        const DebtDateSelector(),
        const DebtAccountSelector(),
        const DebtDueSelector(),
        AppTextField(
          label: 'Qeyd (istəyə bağlı)',
          kind: FieldKind.name,
          onChanged: cubit.setNote,
        ),
        const DebtEffectNote(),
      ],
    );
  }
}
