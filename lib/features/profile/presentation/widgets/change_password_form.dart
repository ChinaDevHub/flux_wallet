import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/alerts/alert_scope.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/core/widgets/sheet_heading.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/change_password_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/change_password_state.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/change_password_fields.dart';

/// Köhnə şifrə + yeni şifrə (twice); closes itself when the password changed.
class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChangePasswordCubit>();
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (_, s) => s.status == PasswordStatus.done,
      listener: (context, _) {
        context.alerts.success('Şifrə dəyişdirildi');
        Navigator.pop(context);
      },
      builder: (context, s) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: SheetHeading('Şifrəni dəyiş'),
            ),
            ChangePasswordFields(cubit: cubit, s: s),
            PrimaryButton(
              label: 'Şifrəni dəyiş',
              loading: s.status == PasswordStatus.saving,
              onPressed: s.canSubmit ? cubit.submit : null,
            ),
          ],
        ),
      ),
    );
  }
}
