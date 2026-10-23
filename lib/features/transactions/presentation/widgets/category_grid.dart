import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_categories.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/category_picker.dart';

/// The "+" form's categories for the chosen kind.
class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) => a.kind != b.kind || a.category != b.category,
      builder: (context, s) => CategoryPicker(
        categories: categoriesFor(s.kind),
        selected: s.category,
        onSelected: context.read<NewTransactionCubit>().setCategory,
      ),
    );
  }
}
