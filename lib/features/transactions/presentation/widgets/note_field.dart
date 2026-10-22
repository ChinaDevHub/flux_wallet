import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/app_text_field.dart';
import 'package:flux_wallet/core/widgets/field_kind.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';

class NoteField extends StatelessWidget {
  const NoteField({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Qeyd (məsələn: Supermarket)',
      kind: FieldKind.name,
      onChanged: context.read<NewTransactionCubit>().setNote,
    );
  }
}
