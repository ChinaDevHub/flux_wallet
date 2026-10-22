import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/platform_icon.dart';

/// Tabs, the top bar and the main entry points.
abstract final class NavIcons {
  static IconData get home =>
      platformIcon(Icons.home_rounded, CupertinoIcons.house_fill);
  static IconData get timeline =>
      platformIcon(Icons.history_rounded, CupertinoIcons.clock);
  static IconData get debts => platformIcon(
    Icons.account_balance_wallet_outlined,
    CupertinoIcons.creditcard,
  );
  static IconData get stats =>
      platformIcon(Icons.bar_chart_rounded, CupertinoIcons.chart_bar_alt_fill);
  static IconData get settings =>
      platformIcon(Icons.settings_outlined, CupertinoIcons.gear);
  static IconData get bell =>
      platformIcon(Icons.notifications_none_rounded, CupertinoIcons.bell);
  static IconData get bellActive => platformIcon(
    Icons.notifications_active_outlined,
    CupertinoIcons.bell_fill,
  );
}
