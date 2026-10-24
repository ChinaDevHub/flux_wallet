import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/icons/limit_icons.dart';
import 'package:flux_wallet/features/home/domain/entities/limit_status.dart';

/// Words, colour and mark of each state. The colours read on the green card
/// and follow what people expect of them: mint for "all good", sunny amber
/// for "slow down", warm orange for "over", red for "real trouble". Every
/// state but calm also pulses, so a glance is enough.
extension LimitStatusStyle on LimitStatus {
  String get label => switch (this) {
    LimitStatus.calm => 'Normadadır',
    LimitStatus.careful => 'Limitə yaxın',
    LimitStatus.over => 'Limit aşılıb',
    LimitStatus.shortfall => 'Çatışmazlıq',
  };

  Color get color => switch (this) {
    LimitStatus.calm => const Color(0xFF7CF0BF),
    LimitStatus.careful => const Color(0xFFFFD166),
    LimitStatus.over => const Color(0xFFFF8A5B),
    LimitStatus.shortfall => const Color(0xFFFF5C6C),
  };

  IconData get icon => switch (this) {
    LimitStatus.calm => LimitIcons.calm,
    LimitStatus.careful => LimitIcons.careful,
    LimitStatus.over => LimitIcons.over,
    LimitStatus.shortfall => LimitIcons.shortfall,
  };

  bool get pulses => this != LimitStatus.calm;

  /// The limit bar: plain white while calm, the state's colour otherwise.
  Color get barColor => pulses ? color : const Color(0xFFFFFFFF);
}
