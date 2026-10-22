import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/platform_icon.dart';

/// Feedback, hints and calendar marks.
abstract final class StatusIcons {
  static IconData get success => platformIcon(
    Icons.check_circle_rounded,
    CupertinoIcons.checkmark_circle_fill,
  );
  static IconData get error =>
      platformIcon(Icons.error_rounded, CupertinoIcons.xmark_circle_fill);
  static IconData get info =>
      platformIcon(Icons.info_rounded, CupertinoIcons.info_circle_fill);
  static IconData get warning => platformIcon(
    Icons.warning_amber_rounded,
    CupertinoIcons.exclamationmark_triangle,
  );
  static IconData get tip =>
      platformIcon(Icons.lightbulb_outline_rounded, CupertinoIcons.lightbulb);
  static IconData get inbox =>
      platformIcon(Icons.inbox_outlined, CupertinoIcons.tray);
  static IconData get alarm =>
      platformIcon(Icons.alarm_rounded, CupertinoIcons.alarm);
  static IconData get today =>
      platformIcon(Icons.today_rounded, CupertinoIcons.calendar_today);
  static IconData get dayOff => platformIcon(
    Icons.event_busy_rounded,
    CupertinoIcons.calendar_badge_minus,
  );
  static IconData get checklist =>
      platformIcon(Icons.fact_check_outlined, CupertinoIcons.checkmark_square);
}
