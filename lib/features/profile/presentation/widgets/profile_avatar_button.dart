import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_state.dart';
import 'package:flux_wallet/features/profile/presentation/pages/open_profile_page.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/user_avatar.dart';

/// The top-bar account button: shows the avatar, opens the profile.
class ProfileAvatarButton extends StatelessWidget {
  const ProfileAvatarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, s) => InkResponse(
        onTap: () => openProfilePage(context),
        radius: 24,
        child: UserAvatar(
          avatarUrl: s.user?.avatarUrl,
          fullName: s.user?.fullName ?? '',
        ),
      ),
    );
  }
}
