import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/platform_icon.dart';

/// Sign-in, profile and password marks.
abstract final class AccountIcons {
  static IconData get show =>
      platformIcon(Icons.visibility_outlined, CupertinoIcons.eye);
  static IconData get hide =>
      platformIcon(Icons.visibility_off_outlined, CupertinoIcons.eye_slash);
  static IconData get logout =>
      platformIcon(Icons.logout_rounded, CupertinoIcons.arrow_right_square);
  static IconData get changePassword =>
      platformIcon(Icons.lock_reset_rounded, CupertinoIcons.lock_rotation);
  static IconData get gallery => platformIcon(
    Icons.photo_library_outlined,
    CupertinoIcons.photo_on_rectangle,
  );
}
