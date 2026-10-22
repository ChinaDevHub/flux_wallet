import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/auth_mode_cubit.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/auth_header.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/auth_switch_button.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/login_form.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/register_form.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<AuthModeCubit>();
    final registering = mode.state == AuthMode.register;
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        AuthHeader(
          title: registering ? 'Hesab yarat' : 'Xoş gəldin',
          subtitle: registering
              ? 'Hər istifadəçinin büdcəsi ayrı saxlanılır və yalnız bu cihazdadır.'
              : 'Büdcənə daxil olmaq üçün giriş et.',
        ),
        const SizedBox(height: 28),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: registering
              ? const RegisterForm(key: ValueKey('register'))
              : const LoginForm(key: ValueKey('login')),
        ),
        const SizedBox(height: 8),
        AuthSwitchButton(
          label: registering
              ? 'Artıq hesabın var? Giriş'
              : 'Hesabın yoxdur? Qeydiyyat',
          onTap: () =>
              mode.show(registering ? AuthMode.login : AuthMode.register),
        ),
      ],
    );
  }
}
