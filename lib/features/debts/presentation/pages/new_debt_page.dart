import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/new_debt_form.dart';

class NewDebtPage extends StatelessWidget {
  const NewDebtPage({super.key});

  void _onState(BuildContext context, NewDebtState s) {
    if (s.status == DebtSaveStatus.done) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yadda saxlamaq alınmadı. Yenidən cəhd et'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewDebtCubit, NewDebtState>(
      listenWhen: (_, s) =>
          s.status == DebtSaveStatus.done || s.status == DebtSaveStatus.failure,
      listener: _onState,
      child: Scaffold(
        appBar: AppBar(title: const Text('Yeni borc')),
        body: const SafeArea(child: NewDebtForm()),
      ),
    );
  }
}
