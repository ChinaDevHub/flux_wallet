import 'package:flutter_test/flutter_test.dart';

/// Lets [ms] milliseconds of animation and timers play out, frame by frame
/// (one big pump would skip the animation ticks).
Future<void> pumpFor(WidgetTester t, int ms) async {
  for (var spent = 0; spent < ms; spent += 50) {
    await t.pump(const Duration(milliseconds: 50));
  }
}
