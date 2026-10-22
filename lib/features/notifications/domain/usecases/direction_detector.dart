import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

final _incomeWords = RegExp(
  r'(mədaxil|medaxil|daxil oldu|alındı|credit|received|refund|qaytarma|'
  r'salary|maaş|əmək haqqı|пополнение|поступление)',
  caseSensitive: false,
);

/// Bank texts are expenses unless they clearly announce incoming money.
TxType detectDirection(String text) =>
    _incomeWords.hasMatch(text) ? TxType.income : TxType.expense;
