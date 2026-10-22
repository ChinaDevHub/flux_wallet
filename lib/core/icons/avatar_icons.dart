import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/platform_icon.dart';

/// The glyphs of the built-in profile avatars.
abstract final class AvatarIcons {
  static IconData get person =>
      platformIcon(Icons.person_rounded, CupertinoIcons.person_fill);
  static IconData get face =>
      platformIcon(Icons.face_rounded, CupertinoIcons.smiley_fill);
  static IconData get pet =>
      platformIcon(Icons.pets_rounded, CupertinoIcons.paw);
  static IconData get game => platformIcon(
    Icons.sports_esports_rounded,
    CupertinoIcons.game_controller_solid,
  );
  static IconData get rocket =>
      platformIcon(Icons.rocket_launch_rounded, CupertinoIcons.rocket_fill);
  static IconData get flower =>
      platformIcon(Icons.local_florist_rounded, CupertinoIcons.tree);
  static IconData get coffee =>
      platformIcon(Icons.coffee_rounded, CupertinoIcons.heart_fill);
  static IconData get star =>
      platformIcon(Icons.star_rounded, CupertinoIcons.star_fill);
}
