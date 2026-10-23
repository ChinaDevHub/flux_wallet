import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import 'package:flux_wallet/core/widgets/manage/row_action.dart';
import 'package:flux_wallet/core/widgets/manage/swipe_actions.dart';

void main() {
  Future<List<String>> pump(WidgetTester t, TargetPlatform platform) async {
    final done = <String>[];
    await t.pumpWidget(
      MaterialApp(
        theme: AppTheme.light.copyWith(platform: platform),
        home: Scaffold(
          body: SwipeActions(
            title: 'Avtobus',
            actions: [
              RowAction(
                label: 'Redaktə et',
                icon: Icons.edit,
                onTap: () => done.add('edit'),
              ),
              RowAction(
                label: 'Sil',
                icon: Icons.delete,
                destructive: true,
                onTap: () => done.add('delete'),
              ),
            ],
            child: const SizedBox(
              height: 60,
              width: 400,
              child: Text('Avtobus sətri'),
            ),
          ),
        ),
      ),
    );
    return done;
  }

  for (final platform in [TargetPlatform.android, TargetPlatform.iOS]) {
    testWidgets('long press offers the same actions ($platform)', (t) async {
      final done = await pump(t, platform);
      await t.longPress(find.text('Avtobus sətri'));
      await t.pumpAndSettle();
      expect(find.text('Redaktə et'), findsOneWidget);
      await t.tap(find.text('Sil'));
      await t.pumpAndSettle();
      expect(done, ['delete']);
      expect(find.text('Redaktə et'), findsNothing, reason: 'the menu closed');
    });

    testWidgets('swiping left reveals the buttons ($platform)', (t) async {
      final done = await pump(t, platform);
      await t.drag(find.text('Avtobus sətri'), const Offset(-300, 0));
      await t.pumpAndSettle();
      await t.tap(find.text('Redaktə et'));
      await t.pumpAndSettle();
      expect(done, ['edit']);
    });
  }
}
