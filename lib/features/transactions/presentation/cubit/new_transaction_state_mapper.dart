import 'package:flux_wallet/core/widgets/category_style.dart';
import 'package:flux_wallet/features/transactions/domain/entities/new_transaction.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';

extension NewTransactionStateMapper on NewTransactionState {
  /// Only valid when [canSubmit] is true.
  NewTransaction toNewTransaction() {
    final category = this.category!;
    final text = note.trim();
    return NewTransaction(
      kind: kind,
      amount: amount,
      category: category,
      accountId: accountId!,
      date: date,
      title: text.isEmpty ? CategoryStyle.of(category).label : text,
      note: text.isEmpty ? null : text,
      repeat: repeat,
    );
  }

  /// The edited transaction as the form now describes it.
  Transaction toTransaction() => Transaction(
    amount: amount,
    type: kind.type,
    category: category!,
    accountId: accountId!,
    date: date,
    note: note.trim().isEmpty ? null : note.trim(),
  );
}
