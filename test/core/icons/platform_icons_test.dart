import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/icons/account_icons.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/core/icons/arrow_icons.dart';
import 'package:flux_wallet/core/icons/avatar_icons.dart';
import 'package:flux_wallet/core/icons/category_icons.dart';
import 'package:flux_wallet/core/icons/nav_icons.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';

/// Every icon the app uses, read at the moment of the call.
List<IconData> allIcons() => [
  NavIcons.home,
  NavIcons.timeline,
  NavIcons.debts,
  NavIcons.stats,
  NavIcons.settings,
  NavIcons.bell,
  NavIcons.bellActive,
  ActionIcons.add,
  ActionIcons.addCircle,
  ActionIcons.edit,
  ActionIcons.editNote,
  ActionIcons.delete,
  ActionIcons.check,
  ActionIcons.undo,
  ActionIcons.repeat,
  ActionIcons.exportFile,
  ActionIcons.importFile,
  ArrowIcons.next,
  ArrowIcons.down,
  ArrowIcons.forward,
  StatusIcons.success,
  StatusIcons.error,
  StatusIcons.info,
  StatusIcons.warning,
  StatusIcons.tip,
  StatusIcons.inbox,
  StatusIcons.alarm,
  StatusIcons.today,
  StatusIcons.dayOff,
  StatusIcons.checklist,
  AccountIcons.show,
  AccountIcons.hide,
  AccountIcons.logout,
  AccountIcons.changePassword,
  AccountIcons.gallery,
  CategoryIcons.taxi,
  CategoryIcons.bus,
  CategoryIcons.grocery,
  CategoryIcons.cafe,
  CategoryIcons.rent,
  CategoryIcons.debt,
  CategoryIcons.utilities,
  CategoryIcons.fuel,
  CategoryIcons.gift,
  CategoryIcons.repayment,
  CategoryIcons.salary,
  CategoryIcons.other,
  AvatarIcons.person,
  AvatarIcons.face,
  AvatarIcons.pet,
  AvatarIcons.game,
  AvatarIcons.rocket,
  AvatarIcons.flower,
  AvatarIcons.coffee,
  AvatarIcons.star,
];

void main() {
  tearDown(() => debugDefaultTargetPlatformOverride = null);

  test('Apple platforms only ever get SF-style (Cupertino) glyphs', () {
    for (final p in [TargetPlatform.iOS, TargetPlatform.macOS]) {
      debugDefaultTargetPlatformOverride = p;
      for (final icon in allIcons()) {
        expect(icon.fontFamily, 'CupertinoIcons');
      }
    }
  });

  test('Android (and the rest) only ever get Material glyphs', () {
    for (final p in [TargetPlatform.android, TargetPlatform.fuchsia]) {
      debugDefaultTargetPlatformOverride = p;
      for (final icon in allIcons()) {
        expect(icon.fontFamily, 'MaterialIcons');
      }
    }
  });
}
