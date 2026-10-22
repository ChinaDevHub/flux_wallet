import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_direction_selector.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/new_debt_fields.dart';

class NewDebtForm extends StatelessWidget {
  const NewDebtForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NewDebtCubit>();
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        BlocBuilder<NewDebtCubit, NewDebtState>(
          buildWhen: (a, b) => a.direction != b.direction,
          builder: (_, s) => DebtDirectionSelector(
            selected: s.direction,
            onChanged: cubit.setDirection,
          ),
        ),
        const SizedBox(height: 20),
        const NewDebtFields(),
        const SizedBox(height: 20),
        BlocBuilder<NewDebtCubit, NewDebtState>(
          builder: (_, s) => PrimaryButton(
            label: 'Yadda saxla',
            loading: s.status == DebtSaveStatus.saving,
            onPressed: s.canSubmit ? cubit.submit : null,
          ),
        ),
      ],
    );
  }
}
