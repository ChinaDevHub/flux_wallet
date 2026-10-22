import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_edit_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_edit_state.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/profile_fields.dart';

/// The editable fields and "Dəyişiklikləri saxla" (enabled once something
/// valid has changed); a snackbar confirms the save.
class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  void _onState(BuildContext context, ProfileEditState s) {
    final text = switch (s.status) {
      ProfileSaveStatus.saved => 'Yadda saxlandı',
      ProfileSaveStatus.failed => 'Yadda saxlamaq alınmadı',
      _ => null,
    };
    if (text == null) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
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
