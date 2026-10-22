import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_sheet.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/payment_sheet.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';

void showPaymentSheet(
  BuildContext context,
  DebtsCubit cubit,
  DebtSummary summary,
  List<Account> accounts,
) => showAppSheet<void>(
  context,
  (_) => PaymentSheet(
    summary: summary,
    accounts: accounts,
    onPay: (amount, account) => cubit.pay(summary, amount, account),
  ),
);
