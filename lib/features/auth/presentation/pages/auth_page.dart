import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/auth_mode_cubit.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/register_cubit.dart';
import 'package:flux_wallet/features/auth/presentation/widgets/auth_body.dart';

/// Sign in / create account; the session switches the screen after success.
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final u = context.read<AppDependencies>().useCases;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (c) =>
              AuthModeCubit(c.read<AppDependencies>().repos.users)..load(),
        ),
        BlocProvider(create: (_) => LoginCubit(u.loginUser, u.passwordHint)),
        BlocProvider(create: (_) => RegisterCubit(u.registerUser)),
      ],
      child: const Scaffold(body: SafeArea(child: AuthBody())),
    );
  }
}
