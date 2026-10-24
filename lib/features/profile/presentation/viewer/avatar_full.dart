import 'package:flutter/material.dart';
import 'package:flux_wallet/core/files/app_files.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/profile/domain/entities/avatar.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/user_avatar.dart';

/// What the viewer shows: a picked photo edge to edge, or the preset /
/// initials avatar drawn large.
class AvatarFull extends StatelessWidget {
  const AvatarFull({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final name = Avatar.fileName(user.avatarUrl);
    final file = name == null ? null : AppFiles.avatar(name);
    if (file != null && file.existsSync()) {
      return Image.file(file, fit: BoxFit.contain, width: double.infinity);
    }
    final side = MediaQuery.sizeOf(context).width * 0.36;
    return UserAvatar(
      avatarUrl: user.avatarUrl,
      fullName: user.fullName,
      radius: side,
    );
  }
}
