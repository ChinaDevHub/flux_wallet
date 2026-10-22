// Regenerates every launcher icon from the same painter the app draws its
// logo with:  flutter test tool/brand_assets_test.dart
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/branding/brand_colors.dart';
import 'package:flux_wallet/core/branding/logo_mark_painter.dart';

import 'png_encoder.dart';

/// Draws [paint] on a [px] x [px] canvas and returns its RGBA pixels.
Future<ui.Image> render(int px, void Function(Canvas, Size) paint) {
  final recorder = ui.PictureRecorder();
  paint(Canvas(recorder), Size(px.toDouble(), px.toDouble()));
  return recorder.endRecording().toImage(px, px);
}

void fillTile(Canvas c, Size s, {double radius = 0}) {
  final rect = Offset.zero & s;
  c.drawRRect(
    RRect.fromRectAndRadius(rect, Radius.circular(s.width * radius)),
    Paint()..shader = brandGradient.createShader(rect),
  );
}

Future<void> write(String path, ui.Image image, {bool opaque = false}) async {
  final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  final bytes = opaque
      ? encodeRgbPng(image.width, image.height, data!.buffer.asUint8List())
      : (await image.toByteData(
          format: ui.ImageByteFormat.png,
        ))!.buffer.asUint8List();
  File(path)
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes);
}

void main() {
  testWidgets('writes the iOS and Android icons', (tester) async {
    await tester.runAsync(() async {
      const mark = LogoMarkPainter();
      // iOS: opaque, full-bleed (the system rounds it).
      final set = 'ios/Runner/Assets.xcassets/AppIcon.appiconset';
      final contents =
          jsonDecode(File('$set/Contents.json').readAsStringSync())
              as Map<String, dynamic>;
      for (final e in contents['images'] as List) {
        final side = double.parse((e['size'] as String).split('x').first);
        final px =
            (side * int.parse((e['scale'] as String).replaceAll('x', '')))
                .round();
        final image = await render(px, (c, s) {
          fillTile(c, s);
          mark.paint(c, s);
        });
        await write('$set/${e['filename']}', image, opaque: true);
      }
      // Android 8+: adaptive icon = gradient background + the mark, scaled
      // into the safe zone; plus a one-colour version for themed icons.
      const dpi = {
        'mdpi': 108,
        'hdpi': 162,
        'xhdpi': 216,
        'xxhdpi': 324,
        'xxxhdpi': 432,
      };
      const res = 'android/app/src/main/res';
      for (final e in dpi.entries) {
        final fg = await render(e.value, (c, s) {
          const LogoMarkPainter(scale: 0.8).paint(c, s);
        });
        await write('$res/drawable-${e.key}/ic_launcher_foreground.png', fg);
        final mono = await render(e.value, (c, s) {
          const LogoMarkPainter(coin: brandInk, scale: 0.8).paint(c, s);
        });
        await write('$res/drawable-${e.key}/ic_launcher_monochrome.png', mono);
      }
      // Android 7 and older: a rounded tile.
      const legacy = {
        'mdpi': 48,
        'hdpi': 72,
        'xhdpi': 96,
        'xxhdpi': 144,
        'xxxhdpi': 192,
      };
      for (final e in legacy.entries) {
        final image = await render(e.value, (c, s) {
          fillTile(c, s, radius: 0.22);
          mark.paint(c, s);
        });
        await write('$res/mipmap-${e.key}/ic_launcher.png', image);
      }
    });
  });
}
