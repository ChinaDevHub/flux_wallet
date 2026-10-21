import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';

abstract interface class ProfileRepository {
  /// Null until onboarding has been completed.
  Future<String?> readName();

  /// Atomically creates accounts, the salary rule and the profile name.
  Future<void> completeOnboarding(OnboardingData data, DateTime today);
}
