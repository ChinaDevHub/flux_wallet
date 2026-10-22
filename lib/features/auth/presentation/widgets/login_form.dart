import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/app_text_field.dart';
import 'package:flux_wallet/core/widgets/field_kind.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/login_actions.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/password_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Column(
      spacing: 14,
      children: [
        AppTextField(
          label: 'İstifadəçi adı',
          kind: FieldKind.username,
          action: TextInputAction.next,
          onChanged: cubit.setUsername,
        ),
        PasswordField(
          label: 'Şifrə',
          action: TextInputAction.done,
          onChanged: cubit.setPassword,
          onSubmitted: (_) => cubit.submit(),
        ),
        const LoginActions(),
      ],
    );
  }
}
