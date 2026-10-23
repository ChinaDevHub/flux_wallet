import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/platform_icon.dart';

/// Direction and disclosure marks.
abstract final class ArrowIcons {
  static IconData get next =>
      platformIcon(Icons.chevron_right_rounded, CupertinoIcons.chevron_right);
  static IconData get prev =>
      platformIcon(Icons.chevron_left_rounded, CupertinoIcons.chevron_left);
  static IconData get down =>
      platformIcon(Icons.expand_more_rounded, CupertinoIcons.chevron_down);
  static IconData get up =>
      platformIcon(Icons.expand_less_rounded, CupertinoIcons.chevron_up);
  static IconData get forward =>
      platformIcon(Icons.arrow_forward_rounded, CupertinoIcons.arrow_right);
}
