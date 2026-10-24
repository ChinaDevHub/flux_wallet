import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/month_range_slider.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/preset_picker.dart';

void main() {
  final months = StatsRange(DateTime(2026, 5), DateTime(2026, 10)).months;

  Widget app(Widget child, [TargetPlatform p = TargetPlatform.android]) =>
      MaterialApp(
        theme: AppTheme.light.copyWith(platform: p),
        home: Scaffold(
          body: Padding(padding: const EdgeInsets.all(20), child: child),
        ),
      );

  for (final p in [TargetPlatform.android, TargetPlatform.iOS]) {
    testWidgets('a preset is picked with one tap ($p)', (t) async {
      final picked = <StatsPreset>[];
      await t.pumpWidget(
        app(PresetPicker(current: StatsPreset.six, onPick: picked.add), p),
      );
      await t.tap(find.text('3 ay'));
      await t.tap(find.text('Xüsusi'));
      await t.pumpAndSettle();
      expect(picked, [
        StatsPreset.three,
      ], reason: 'Xüsusi only marks the slider');
    });

    testWidgets('dragging a knob reports the new period on lift ($p)', (
      t,
    ) async {
      final ranges = <StatsRange>[];
      await t.pumpWidget(
        app(
          MonthRangeSlider(
            months: months,
            range: StatsRange(DateTime(2026, 5), DateTime(2026, 10)),
            onRange: ranges.add,
          ),
          p,
        ),
      );
      final slider = find.byType(RangeSlider);
      final left = t.getTopLeft(slider) + const Offset(24, 24);
      await t.dragFrom(left, const Offset(180, 0));
      await t.pumpAndSettle();
      expect(ranges, hasLength(1));
      expect(ranges.single.to, DateTime(2026, 10));
      expect(ranges.single.from.isAfter(DateTime(2026, 5)), isTrue);
    });
  }
}
