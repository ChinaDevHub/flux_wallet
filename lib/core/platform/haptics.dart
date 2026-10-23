import 'package:flutter/services.dart';

/// [action] with the light "selection" tick both platforms use for picks.
VoidCallback withTick(VoidCallback action) => () {
  HapticFeedback.selectionClick();
  action();
};
