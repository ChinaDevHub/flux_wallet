import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/alerts/alert_scope.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/new_transaction_form.dart';

class NewTransactionPage extends StatelessWidget {
  const NewTransactionPage({super.key});

  String _success(NewTransactionState s) => s.isEditing
      ? 'Dəyişikliklər saxlandı'
      : s.isPlan
      ? 'Plan əlavə olundu'
      : 'Əməliyyat əlavə olundu';

  void _onState(BuildContext context, NewTransactionState s) {
    if (s.status == SaveStatus.done) {
      context.alerts.success(_success(s));
      Navigator.pop(context);
    } else {
      context.alerts.error('Yadda saxlamaq alınmadı. Yenidən cəhd et');
    }
  }

  @override
  Widget build(BuildContext context) {
    final editing = context.read<NewTransactionCubit>().state.isEditing;
    return BlocListener<NewTransactionCubit, NewTransactionState>(
      listenWhen: (_, s) =>
          s.status == SaveStatus.done || s.status == SaveStatus.failure,
      listener: _onState,
      child: Scaffold(
        appBar: AppBar(
          title: Text(editing ? 'Əməliyyatı redaktə et' : 'Yeni Əməliyyat'),
        ),
        body: const SafeArea(child: NewTransactionForm()),
      ),
    );
  }
}
