import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/platform/adaptive_sheet.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/change_password_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/change_password_form.dart';

/// The sheet lives in its own route, so it gets its own cubit.
void showPasswordSheet(BuildContext context) {
  final change = context.read<AppDependencies>().useCases.changePassword;
  showAppSheet<void>(
    context,
    (_) => BlocProvider(
      create: (_) => ChangePasswordCubit(change),
      child: const ChangePasswordForm(),
    ),
  );
}
