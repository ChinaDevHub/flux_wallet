import 'package:flutter/widgets.dart';

/// One thing that can be done to a row: Redaktə et, Sil, ... The same list
/// drives the swipe buttons, the long-press sheet and the buttons inside an
/// expanded row, so every screen offers the same actions the same way.
class RowAction {
  const RowAction({
    required this.label,
    required this.icon,
    required this.onTap,
    this.destructive = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  /// Shown in red (delete).
  final bool destructive;
}
