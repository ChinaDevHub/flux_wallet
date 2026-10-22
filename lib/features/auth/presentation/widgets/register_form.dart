import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/register_cubit.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/register_state.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/auth_error_text.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/register_errors.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/register_fields.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, s) {
        final errors = RegisterErrors(s);
        return Column(
          spacing: 14,
          children: [
            RegisterFields(cubit: cubit, errors: errors),
            if (errors.general != null) AuthErrorText(errors.general!),
            PrimaryButton(
              label: 'Qeydiyyatdan keç',
              loading: s.status == RegisterStatus.loading,
              onPressed: s.canSubmit ? cubit.submit : null,
            ),
          ],
        );
      },
    );
  }
}
