import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_circle_button.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_state.dart';
import 'package:flux_wallet/features/profile/presentation/pages/open_profile_page.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/avatar_ring.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/user_avatar.dart';

/// The top-bar account button: the avatar in its platform's frame and
/// press feedback; it opens the profile.
class ProfileAvatarButton extends StatelessWidget {
  const ProfileAvatarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, s) => AdaptiveCircleButton(
        semanticLabel: 'Profil',
        onTap: () => openProfilePage(context),
        child: AvatarRing(
          child: UserAvatar(
            avatarUrl: s.user?.avatarUrl,
            fullName: s.user?.fullName ?? '',
            radius: 17,
          ),
        ),
      ),
    );
  }
}
