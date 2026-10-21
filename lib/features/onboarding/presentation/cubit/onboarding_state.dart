import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';

enum OnboardingStatus { editing, saving, done, failure }

class OnboardingState extends Equatable {
  const OnboardingState({this.status = OnboardingStatus.editing, this.data});

  final OnboardingStatus status;

  /// Non-null only while the current form input is valid.
  final OnboardingData? data;

  bool get canSubmit => data != null && status != OnboardingStatus.saving;

  @override
  List<Object?> get props => [status, data];
}
