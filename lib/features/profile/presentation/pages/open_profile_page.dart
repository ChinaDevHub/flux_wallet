import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/pages/profile_page.dart';

Future<void> openProfilePage(BuildContext context) {
  final deps = context.read<AppDependencies>();
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (_) => newProfileCubit(deps)..load(),
        child: const ProfilePage(),
      ),
    ),
  );
}

ProfileCubit newProfileCubit(AppDependencies deps) => ProfileCubit(
  deps.repos.users,
  deps.useCases.setAvatar,
  deps.useCases.logoutUser,
  deps.changes,
);
