import 'package:flutter/material.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/password_field.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/change_password_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/change_password_state.dart';

class ChangePasswordFields extends StatelessWidget {
  const ChangePasswordFields({super.key, required this.cubit, required this.s});

  final ChangePasswordCubit cubit;
  final ChangePasswordState s;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        PasswordField(
          label: 'Köhnə şifrə',
          action: TextInputAction.next,
          errorText: s.status == PasswordStatus.wrongPassword
              ? 'Köhnə şifrə yanlışdır'
              : null,
          onChanged: cubit.setOld,
        ),
        PasswordField(
          label: 'Yeni şifrə',
          action: TextInputAction.next,
          errorText: s.newPassword.isEmpty || s.newLongEnough
              ? null
              : 'Şifrə çox qısadır',
          onChanged: cubit.setNew,
        ),
        PasswordField(
          label: 'Yeni şifrə (təkrar)',
          action: TextInputAction.done,
          errorText: s.confirm.isEmpty || s.matches
              ? null
              : 'Şifrələr eyni deyil',
          onChanged: cubit.setConfirm,
        ),
      ],
    );
  }
}
