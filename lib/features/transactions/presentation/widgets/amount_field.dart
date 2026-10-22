import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';
import 'package:flux_wallet/core/widgets/amount_text_field.dart';

/// Amount input; the quick-add chips change it through the cubit, so the
/// controller follows the cubit state.
class AmountField extends StatefulWidget {
  const AmountField({super.key});

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewTransactionCubit, NewTransactionState>(
      listenWhen: (a, b) => b.amountText != _controller.text,
      listener: (_, s) => _controller.value = TextEditingValue(
        text: s.amountText,
        selection: TextSelection.collapsed(offset: s.amountText.length),
      ),
      child: AmountTextField(
        controller: _controller,
        onChanged: context.read<NewTransactionCubit>().setAmountText,
      ),
    );
  }
}
