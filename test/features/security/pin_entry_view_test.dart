import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_entry_view.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_prompt.dart';
import '../../support/pump_for.dart';

Future<void> pump(
  WidgetTester t, {
  required ValueChanged<String> onFilled,
  int resetTick = 0,
  String? caption,
  TargetPlatform platform = TargetPlatform.android,
}) => t.pumpWidget(
  MaterialApp(
    theme: AppTheme.light.copyWith(platform: platform),
    home: Scaffold(
      body: PinEntryView(
        length: 4,
        prompt: PinPrompt(
          title: 'Salam, Rauf',
          caption: caption,
          captionError: true,
        ),
        resetTick: resetTick,
        onFilled: onFilled,
      ),
    ),
  ),
);

void main() {
  testWidgets('typing four digits reports the PIN once', (t) async {
    final filled = <String>[];
    await pump(t, onFilled: filled.add);
    for (final d in ['2', '4', '6', '8']) {
      await t.tap(find.text(d));
      await t.pump();
    }
    await t.tap(find.text('1')); // ignored: already complete
    await t.pump();
    expect(filled, ['2468']);
  });

  testWidgets('backspace removes the last digit', (t) async {
    final filled = <String>[];
    await pump(t, onFilled: filled.add);
    await t.tap(find.text('1'));
    await t.tap(find.text('2'));
    await t.pump();
    await t.tap(find.byType(Icon).last); // backspace
    await t.pump();
    await t.tap(find.text('3'));
    await t.tap(find.text('4'));
    await t.tap(find.text('5'));
    await t.pump();
    expect(filled, ['1345']);
  });

  testWidgets('a bumped resetTick clears the pad and shows the caption', (
    t,
  ) async {
    final filled = <String>[];
    await pump(t, onFilled: filled.add);
    await t.tap(find.text('1'));
    await t.pump();
    await pump(t, onFilled: filled.add, resetTick: 1, caption: 'Yanlış PIN');
    await pumpFor(t, 500);
    expect(find.text('Yanlış PIN'), findsOneWidget);
    for (final d in ['2', '4', '6', '8']) {
      await t.tap(find.text(d));
      await t.pump();
    }
    expect(filled, ['2468'], reason: 'the earlier 1 was cleared');
  });

  testWidgets('iOS keys carry the phone-pad letters', (t) async {
    await pump(t, onFilled: (_) {}, platform: TargetPlatform.iOS);
    expect(find.text('ABC'), findsOneWidget);
    expect(find.text('WXYZ'), findsOneWidget);
  });
}
