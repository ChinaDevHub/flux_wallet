import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/onboarding/domain/repositories/profile_repository.dart';
import 'package:flux_wallet/features/onboarding/domain/usecases/validate_onboarding.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._profile, this._clock) : super(const OnboardingState());

  final ProfileRepository _profile;
  final Clock _clock;
  final _form = <String, String>{};

  void changed(String field, String value) {
    _form[field] = value;
    emit(
      OnboardingState(
        data: validateOnboarding(
          name: _form['name'] ?? '',
          card: _form['card'] ?? '',
          cash: _form['cash'] ?? '',
          salary: _form['salary'] ?? '',
          salaryDay: _form['salaryDay'] ?? '',
        ),
      ),
    );
  }

  Future<void> submit() async {
    final data = state.data;
    if (data == null || !state.canSubmit) return;
    emit(OnboardingState(status: OnboardingStatus.saving, data: data));
    try {
      await _profile.completeOnboarding(data, dateOnly(_clock()));
      emit(OnboardingState(status: OnboardingStatus.done, data: data));
    } catch (_) {
      emit(OnboardingState(status: OnboardingStatus.failure, data: data));
    }
  }
}
