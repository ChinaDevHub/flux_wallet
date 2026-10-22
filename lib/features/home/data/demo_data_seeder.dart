import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/auth/domain/usecases/registration_input.dart';
import 'package:flux_wallet/features/home/data/demo_extras.dart';
import 'package:flux_wallet/features/home/data/demo_rules.dart';
import 'package:flux_wallet/features/home/data/demo_transactions.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';

/// Dev helper (`--dart-define=SEED_DEMO=true`): fills an empty database with a
/// demo account — username `rauf`, password `demo1234` — and signs it in.
Future<void> seedDemoData(AppDependencies deps) async {
  if (await deps.repos.users.count() > 0) return;
  final now = deps.clock();
  await deps.useCases.registerUser(
    const RegistrationInput(
      fullName: 'Rauf Əliyev',
      username: 'rauf',
      password: 'demo1234',
      hint: 'Demo şifrəsi: dörd rəqəm və demo sözü',
    ),
  );
  await deps.repos.onboarding.complete(
    const OnboardingData(
      cardBalance: 380,
      cashBalance: 32,
      salaryAmount: 1200,
      salaryDay: 29,
    ),
    dateOnly(now),
  );
  for (final r in demoRules(dateOnly(now))) {
    await deps.repos.rules.add(r);
  }
  for (final t in demoTransactions(now)) {
    await deps.repos.transactions.add(t);
  }
  await seedDebtsAndNotifications(deps, now);
}
