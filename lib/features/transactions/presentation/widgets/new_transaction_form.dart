import 'package:flutter/material.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/account_selector.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/amount_field.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/category_grid.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/date_selector.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/kind_selector.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/note_field.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/quick_amount_chips.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/repeat_chips.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/save_button.dart';

class NewTransactionForm extends StatelessWidget {
  const NewTransactionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: const [
        KindSelector(),
        SizedBox(height: 12),
        AmountField(),
        QuickAmountChips(),
        SizedBox(height: 20),
        CategoryGrid(),
        AccountSelector(),
        DateSelector(),
        SizedBox(height: 8),
        RepeatChips(),
        SizedBox(height: 16),
        NoteField(),
        SizedBox(height: 20),
        SaveButton(),
      ],
    );
  }
}
