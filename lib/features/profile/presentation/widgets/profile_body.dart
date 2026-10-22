import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_edit_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/change_password_button.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/logout_button.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/profile_form.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/profile_header.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/show_avatar_sheet.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final update = context.read<AppDependencies>().useCases.updateProfile;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        ProfileHeader(
          user: user,
          onAvatarTap: () => showAvatarSheet(context, cubit),
        ),
        const SizedBox(height: 24),
        // Keyed by user: the form keeps what is typed while the profile reloads.
        BlocProvider(
          key: ValueKey(user.id),
          create: (_) => ProfileEditCubit(user, update),
          child: const ProfileForm(),
        ),
        const SizedBox(height: 12),
        const ChangePasswordButton(),
        const SizedBox(height: 24),
        LogoutButton(cubit: cubit),
      ],
    );
  }
}
