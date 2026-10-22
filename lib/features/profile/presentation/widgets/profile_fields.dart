import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/field_kind.dart';
import 'package:flux_wallet/core/widgets/prefilled_text_field.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_edit_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_edit_state.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/profile_field_errors.dart';

/// Ad və soyad, istifadəçi adı and the password hint, prefilled and live.
class ProfileFields extends StatelessWidget {
  const ProfileFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileEditCubit>();
    final start = cubit.state;
    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
      builder: (context, s) {
        final e = ProfileFieldErrors(s);
        return Column(
          spacing: 14,
          children: [
            PrefilledTextField(
              initial: start.fullName,
              label: 'Ad və soyad',
              kind: FieldKind.name,
              errorText: e.fullName,
              onChanged: cubit.setFullName,
            ),
            PrefilledTextField(
              initial: start.username,
              label: 'İstifadəçi adı',
              kind: FieldKind.username,
              errorText: e.username,
              onChanged: cubit.setUsername,
            ),
            PrefilledTextField(
              initial: start.hint,
              label: 'Şifrə xatırlatması',
              onChanged: cubit.setHint,
            ),
          ],
        );
      },
    );
  }
}
