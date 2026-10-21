import 'package:flux_wallet/features/transactions/domain/entities/transaction_kind.dart';

const expenseCategories = [
  'taxi',
  'bus',
  'grocery',
  'cafe',
  'rent',
  'utilities',
  'fuel',
  'other',
];

const incomeCategories = ['salary', 'gift', 'other'];

List<String> categoriesFor(TransactionKind kind) => switch (kind) {
  TransactionKind.expense => expenseCategories,
  TransactionKind.income => incomeCategories,
  _ => const [],
};
