import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/login_state.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/auth_error_text.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/hint_button.dart';

/// The wrong-password message with the hint button, and the submit button.
class LoginActions extends StatelessWidget {
  const LoginActions({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, s) => Column(
        spacing: 14,
        children: [
          if (s.offersHint) ...[
            const AuthErrorText('İstifadəçi adı və ya şifrə yanlışdır.'),
            const HintButton(),
          ],
          PrimaryButton(
            label: 'Daxil ol',
            loading: s.status == LoginStatus.loading,
            onPressed: s.canSubmit ? cubit.submit : null,
          ),
        ],
      ),
    );
  }
}
