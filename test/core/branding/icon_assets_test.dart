import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

/// Width, height and colour type read from a PNG header.
({int width, int height, int colorType}) header(String path) {
  final bytes = File(path).readAsBytesSync();
  final d = ByteData.sublistView(Uint8List.fromList(bytes.sublist(0, 26)));
  return (
    width: d.getUint32(16),
    height: d.getUint32(20),
    colorType: d.getUint8(25),
  );
}

void main() {
  test('every iOS icon exists, has its size and no alpha channel', () {
    const set = 'ios/Runner/Assets.xcassets/AppIcon.appiconset';
    final images =
        (jsonDecode(File('$set/Contents.json').readAsStringSync())
                as Map)['images']
            as List;
    expect(images, isNotEmpty);
    for (final e in images) {
      final side = double.parse((e['size'] as String).split('x').first);
      final px = (side * int.parse((e['scale'] as String).replaceAll('x', '')))
          .round();
      final h = header('$set/${e['filename']}');
      expect([h.width, h.height], [px, px], reason: e['filename'] as String);
      expect(h.colorType, 2, reason: '${e['filename']} must be opaque RGB');
    }
  });

  test('the Android launcher icons exist in every density', () {
    const res = 'android/app/src/main/res';
    const legacy = {
      'mdpi': 48,
      'hdpi': 72,
      'xhdpi': 96,
      'xxhdpi': 144,
      'xxxhdpi': 192,
    };
    for (final e in legacy.entries) {
      final h = header('$res/mipmap-${e.key}/ic_launcher.png');
      expect([h.width, h.height], [e.value, e.value], reason: e.key);
    }
    const adaptive = {
      'mdpi': 108,
      'hdpi': 162,
      'xhdpi': 216,
      'xxhdpi': 324,
      'xxxhdpi': 432,
    };
    for (final e in adaptive.entries) {
      for (final name in ['ic_launcher_foreground', 'ic_launcher_monochrome']) {
        final h = header('$res/drawable-${e.key}/$name.png');
        expect(
          [h.width, h.height],
          [e.value, e.value],
          reason: '$name ${e.key}',
        );
      }
    }
    final xml = File(
      '$res/mipmap-anydpi-v26/ic_launcher.xml',
    ).readAsStringSync();
    for (final part in ['background', 'foreground', 'monochrome']) {
      expect(xml, contains('<$part'));
    }
    expect(
      File('$res/drawable/ic_launcher_background.xml').existsSync(),
      isTrue,
    );
  });

  test('the app is called Flux Wallet under its icon', () {
    final manifest = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();
    expect(manifest, contains('android:label="Flux Wallet"'));
    expect(
      File('ios/Runner/Info.plist').readAsStringSync(),
      contains('<string>Flux Wallet</string>'),
    );
  });
}
