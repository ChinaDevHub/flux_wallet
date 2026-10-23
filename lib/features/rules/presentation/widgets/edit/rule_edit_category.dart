import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_cubit.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_state.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_categories.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_kind.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/category_picker.dart';

/// The categories of the rule's own kind (income or expense).
class RuleEditCategory extends StatelessWidget {
  const RuleEditCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RuleEditCubit, RuleEditState>(
      buildWhen: (a, b) => a.category != b.category,
      builder: (context, s) => CategoryPicker(
        categories: categoriesFor(
          s.rule.isIncome ? TransactionKind.income : TransactionKind.expense,
        ),
        selected: s.category,
        onSelected: context.read<RuleEditCubit>().setCategory,
      ),
    );
  }
}
