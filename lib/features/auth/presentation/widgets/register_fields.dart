import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/app_text_field.dart';
import 'package:flux_wallet/core/widgets/field_kind.dart';
import 'package:flux_wallet/features/auth/domain/usecases/registration_input.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/register_cubit.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/password_field.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/register_errors.dart';

class RegisterFields extends StatelessWidget {
  const RegisterFields({super.key, required this.cubit, required this.errors});

  final RegisterCubit cubit;
  final RegisterErrors errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 14,
      children: [
        AppTextField(
          label: 'Ad və soyad',
          kind: FieldKind.name,
          action: TextInputAction.next,
          errorText: errors.fullName,
          onChanged: cubit.setFullName,
        ),
        AppTextField(
          label: 'İstifadəçi adı',
          kind: FieldKind.username,
          hint: 'məs. rauf.aliyev',
          action: TextInputAction.next,
          errorText: errors.username,
          onChanged: cubit.setUsername,
        ),
        PasswordField(
          label: 'Şifrə (min. ${RegistrationInput.minPassword} simvol)',
          action: TextInputAction.next,
          errorText: errors.password,
          onChanged: cubit.setPassword,
        ),
        AppTextField(
          label: 'Şifrə xatırlatması (istəyə bağlı)',
          action: TextInputAction.done,
          errorText: errors.hint,
          onChanged: cubit.setHint,
        ),
      ],
    );
  }
}
