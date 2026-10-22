import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/icons/nav_icons.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';

/// How each kind of notice looks.
extension NoticeStyle on NoticeKind {
  IconData get icon => switch (this) {
    NoticeKind.bankMessages => NavIcons.bellActive,
    NoticeKind.paymentDue => StatusIcons.today,
    NoticeKind.debtDue => StatusIcons.warning,
    NoticeKind.debtOwed => NavIcons.debts,
  };

  Color tint(AppColors c) => switch (this) {
    NoticeKind.bankMessages => c.accent,
    NoticeKind.paymentDue => c.info,
    NoticeKind.debtDue => c.negative,
    NoticeKind.debtOwed => c.accent,
  };

  /// The main tab that shows the details, or null for the approval queue.
  int? get tab => switch (this) {
    NoticeKind.bankMessages => null,
    NoticeKind.paymentDue => 1,
    NoticeKind.debtDue || NoticeKind.debtOwed => 2,
  };
}
