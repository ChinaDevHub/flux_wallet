import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/home/data/demo_rules.dart';
import 'package:flux_wallet/features/home/data/demo_transactions.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';

/// Dev helper (`--dart-define=SEED_DEMO=true`): fills an empty database.
Future<void> seedDemoData(AppDependencies deps) async {
  if (await deps.profile.readName() != null) return;
  final now = deps.clock();
  await deps.profile.completeOnboarding(
    const OnboardingData(
      name: 'Rauf',
      cardBalance: 380,
      cashBalance: 32,
      salaryAmount: 1200,
      salaryDay: 29,
    ),
    dateOnly(now),
  );
  final rules = deps.repos.rules;
  for (final r in demoRules(dateOnly(now))) {
    await rules.add(r);
  }
  final transactions = deps.repos.transactions;
  for (final t in demoTransactions(now)) {
    await transactions.add(t);
  }
}
