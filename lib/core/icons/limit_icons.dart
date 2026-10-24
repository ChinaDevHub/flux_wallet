import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/platform_icon.dart';

/// The marks of the daily limit's state (Home card).
abstract final class LimitIcons {
  static IconData get calm => platformIcon(
    Icons.check_circle_rounded,
    CupertinoIcons.checkmark_circle_fill,
  );
  static IconData get careful =>
      platformIcon(Icons.hourglass_bottom_rounded, CupertinoIcons.hourglass);
  static IconData get over => platformIcon(
    Icons.trending_up_rounded,
    CupertinoIcons.arrow_up_right_circle_fill,
  );
  static IconData get shortfall => platformIcon(
    Icons.error_rounded,
    CupertinoIcons.exclamationmark_circle_fill,
  );
}
