import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/alerts/alert_host.dart';
import 'package:flux_wallet/core/alerts/alert_scope.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import '../../support/pump_for.dart';

Future<void> pumpApp(WidgetTester t, void Function(BuildContext) onTap) =>
    t.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        builder: (_, child) => AlertHost(child: child!),
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => onTap(context),
              child: const Text('go'),
            ),
          ),
        ),
      ),
    );

void main() {
  testWidgets('shows an alert, then removes it after its time', (t) async {
    await pumpApp(t, (c) => c.alerts.success('Saxlandı'));
    await t.tap(find.text('go'));
    await pumpFor(t, 450);
    expect(find.text('Saxlandı'), findsOneWidget);
    await pumpFor(t, 2400);
    await pumpFor(t, 400);
    expect(find.text('Saxlandı'), findsNothing);
  });

  testWidgets('errors stay longer than successes', (t) async {
    await pumpApp(t, (c) => c.alerts.error('Alınmadı'));
    await t.tap(find.text('go'));
    await pumpFor(t, 3000);
    expect(find.text('Alınmadı'), findsOneWidget);
    await pumpFor(t, 2500);
    await pumpFor(t, 400);
    expect(find.text('Alınmadı'), findsNothing);
  });

  testWidgets('a new alert replaces the old one', (t) async {
    await pumpApp(t, (c) {
      c.alerts.info('Birinci');
      c.alerts.warning('İkinci', title: 'Diqqət');
    });
    await t.tap(find.text('go'));
    await pumpFor(t, 500);
    expect(find.text('Birinci'), findsNothing);
    expect(find.text('İkinci'), findsOneWidget);
    expect(find.text('Diqqət'), findsOneWidget);
    await pumpFor(t, 6000);
  });

  testWidgets('the action runs and closes the alert', (t) async {
    var opened = false;
    await pumpApp(t, (c) {
      c.alerts.info('Yeni', actionLabel: 'Bax', onAction: () => opened = true);
    });
    await t.tap(find.text('go'));
    await pumpFor(t, 400);
    await t.tap(find.text('Bax'));
    await pumpFor(t, 500);
    expect(opened, isTrue);
    expect(find.text('Yeni'), findsNothing);
  });

  testWidgets('swiping up or tapping dismisses early', (t) async {
    await pumpApp(t, (c) => c.alerts.error('Xəta'));
    await t.tap(find.text('go'));
    await pumpFor(t, 400);
    await t.fling(find.text('Xəta'), const Offset(0, -200), 800);
    await pumpFor(t, 500);
    expect(find.text('Xəta'), findsNothing);
  });

  testWidgets('without a host alerts are ignored, not a crash', (t) async {
    await t.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => context.alerts.success('x'),
            child: const Text('go'),
          ),
        ),
      ),
    );
    await t.tap(find.text('go'));
    expect(t.takeException(), isNull);
  });
}
