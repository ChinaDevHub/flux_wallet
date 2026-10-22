import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/alerts/alert_scope.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_edit_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_edit_state.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/profile_fields.dart';

/// The editable fields and "Dəyişiklikləri saxla" (enabled once something
/// valid has changed); an alert confirms the save.
class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  void _onState(BuildContext context, ProfileEditState s) {
    if (s.status == ProfileSaveStatus.saved) {
      context.alerts.success('Dəyişikliklər saxlandı');
    } else {
      context.alerts.error('Yadda saxlamaq alınmadı. Yenidən cəhd et');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileEditCubit, ProfileEditState>(
      listenWhen: (_, s) =>
          s.status == ProfileSaveStatus.saved ||
          s.status == ProfileSaveStatus.failed,
      listener: _onState,
      child: Column(
        spacing: 16,
        children: [
          const ProfileFields(),
          BlocBuilder<ProfileEditCubit, ProfileEditState>(
            builder: (context, s) => PrimaryButton(
              label: 'Dəyişiklikləri saxla',
              loading: s.status == ProfileSaveStatus.saving,
              onPressed: s.canSave
                  ? context.read<ProfileEditCubit>().save
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
