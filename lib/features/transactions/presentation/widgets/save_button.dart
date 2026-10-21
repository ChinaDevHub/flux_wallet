import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) => a.canSubmit != b.canSubmit || a.status != b.status,
      builder: (context, s) => PrimaryButton(
        label: 'Yadda saxla',
        loading: s.status == SaveStatus.saving,
        onPressed: s.canSubmit
            ? context.read<NewTransactionCubit>().submit
            : null,
      ),
    );
  }
}
