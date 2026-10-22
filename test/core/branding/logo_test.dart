import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/branding/manat_path.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import 'package:flux_wallet/core/widgets/app_logo.dart';

void main() {
  testWidgets('the logo draws at every size the app uses it', (t) async {
    for (final size in [16.0, 36.0, 56.0, 112.0, 300.0]) {
      await t.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Center(child: AppLogo(size: size)),
        ),
      );
      expect(t.getSize(find.byType(AppLogo)), Size(size, size));
      expect(t.takeException(), isNull);
    }
  });

  test('the manat sign stays inside the ring, centred', () {
    final box = manatPath(100).getBounds();
    expect(box.center.dx, closeTo(50, 0.5));
    expect(box.width, lessThan(40));
    // the ring's inner edge is at 31 - 3.75 = 27.25 from the centre
    for (final corner in [box.topLeft, box.bottomRight, box.topRight]) {
      expect((corner - const Offset(50, 50)).distance, lessThan(27.25));
    }
  });
}
