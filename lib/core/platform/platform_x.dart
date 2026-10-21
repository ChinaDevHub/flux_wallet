import 'package:flutter/material.dart';

extension PlatformX on BuildContext {
  /// True on iOS/macOS, where Cupertino widgets are the native choice.
  bool get isCupertino => switch (Theme.of(this).platform) {
    TargetPlatform.iOS || TargetPlatform.macOS => true,
    _ => false,
  };
}
