import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';

abstract interface class OnboardingRepository {
  /// True once the signed-in user has their accounts.
  Future<bool> isCompleted();

  /// Atomically creates the user's accounts and salary rule.
  Future<void> complete(OnboardingData data, DateTime today);
}
