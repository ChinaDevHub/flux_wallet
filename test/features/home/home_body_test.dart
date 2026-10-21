import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import 'package:flux_wallet/features/home/domain/entities/daily_limit.dart';
import 'package:flux_wallet/features/home/domain/entities/daily_tip.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/presentation/widgets/home_body.dart';

HomeSnapshot snapshot({required double balance, required double obligations}) =>
    HomeSnapshot(
      userName: 'Rauf',
      today: DateTime(2026, 10, 20),
      limit: DailyLimit(
        totalBalance: balance,
        obligations: obligations,
        daysLeft: 9,
        nextIncome: DateTime(2026, 10, 29),
      ),
      dailyBudget: 0,
      spentToday: 0,
      todayTransactions: const [],
      todayPlans: const [],
      upcoming: const [],
      tip: const DailyTip(TipKind.onTrack),
    );

Future<void> pump(WidgetTester t, HomeSnapshot s) => t.pumpWidget(
  MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(
      body: HomeBody(snapshot: s, onRefresh: () async {}),
    ),
  ),
);

void main() {
  testWidgets('shows the shortfall warning when obligations exceed balance', (
    t,
  ) async {
    await pump(t, snapshot(balance: 100, obligations: 250));
    expect(find.text('Məcburi xərclərə 150.00 ₼ çatmır'), findsOneWidget);
    expect(find.text('Çatışmazlıq'), findsOneWidget);
  });

  testWidgets('no warning and empty states when covered', (t) async {
    await pump(t, snapshot(balance: 500, obligations: 100));
    expect(find.textContaining('çatmır'), findsNothing);
    expect(find.text('Bu gün hələ xərc yoxdur'), findsOneWidget);
    expect(find.text('Yaxın 14 gündə ödəniş yoxdur'), findsOneWidget);
  });

  testWidgets('large amounts scale down instead of overflowing', (t) async {
    await t.binding.setSurfaceSize(const Size(375, 812));
    addTearDown(() => t.binding.setSurfaceSize(null));
    await pump(t, snapshot(balance: 412412, obligations: 0));
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);
  });
}
