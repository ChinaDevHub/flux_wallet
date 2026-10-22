import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/alerts/alert_scope.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/new_transaction_form.dart';

class NewTransactionPage extends StatelessWidget {
  const NewTransactionPage({super.key});

  void _onState(BuildContext context, NewTransactionState s) {
    if (s.status == SaveStatus.done) {
      context.alerts.success('Əməliyyat əlavə olundu');
      Navigator.pop(context);
    } else {
      context.alerts.error('Yadda saxlamaq alınmadı. Yenidən cəhd et');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewTransactionCubit, NewTransactionState>(
      listenWhen: (_, s) =>
          s.status == SaveStatus.done || s.status == SaveStatus.failure,
      listener: _onState,
      child: Scaffold(
        appBar: AppBar(title: const Text('Yeni Əməliyyat')),
        body: const SafeArea(child: NewTransactionForm()),
      ),
    );
  }
}
