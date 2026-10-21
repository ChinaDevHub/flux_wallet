import 'package:flux_wallet/features/transactions/domain/entities/account.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';

List<Account> initialAccounts(OnboardingData d) => [
  Account(name: 'Kart', balance: d.cardBalance, type: AccountType.card),
  Account(name: 'Nağd', balance: d.cashBalance, type: AccountType.cash),
];

/// Monthly salary rule; the start month does not matter (day is what counts).
RecurringRule salaryRule(OnboardingData d, DateTime today) => RecurringRule(
  title: 'Maaş',
  amount: d.salaryAmount!,
  category: 'salary',
  frequency: Frequency.monthly,
  startDate: DateTime(today.year, today.month, d.salaryDay!),
  type: TxType.income,
);
