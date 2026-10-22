import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// The glyph for the running platform: SF-style on Apple, Material elsewhere.
IconData platformIcon(IconData material, IconData cupertino) =>
    switch (defaultTargetPlatform) {
      TargetPlatform.iOS || TargetPlatform.macOS => cupertino,
      _ => material,
    };
