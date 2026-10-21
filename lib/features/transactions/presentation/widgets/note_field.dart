import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/app_text_field.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';

class NoteField extends StatelessWidget {
  const NoteField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) => a.kind.isPerson != b.kind.isPerson,
      builder: (context, s) => AppTextField(
        label: s.kind.isPerson
            ? 'Kimə / kimdən'
            : 'Qeyd (məsələn: Supermarket)',
        capitalize: true,
        onChanged: context.read<NewTransactionCubit>().setNote,
      ),
    );
  }
}
