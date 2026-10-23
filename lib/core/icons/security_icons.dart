import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/platform_icon.dart';

/// The PIN lock and the keypad.
abstract final class SecurityIcons {
  static IconData get lock =>
      platformIcon(Icons.lock_outline_rounded, CupertinoIcons.lock);
  static IconData get lockFilled =>
      platformIcon(Icons.lock_rounded, CupertinoIcons.lock_fill);
  static IconData get changePin =>
      platformIcon(Icons.pin_rounded, CupertinoIcons.number_square);
  static IconData get timer =>
      platformIcon(Icons.timer_outlined, CupertinoIcons.timer);
  static IconData get backspace =>
      platformIcon(Icons.backspace_outlined, CupertinoIcons.delete_left);
}
