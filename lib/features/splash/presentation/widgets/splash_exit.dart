import 'package:flutter/widgets.dart';

/// The splash leaves by fading while it swells a little, as if the app
/// were rising through it.
Widget splashExit(Widget child, Animation<double> animation) => FadeTransition(
  opacity: animation,
  child: ScaleTransition(
    scale: Tween(begin: 1.06, end: 1.0).animate(animation),
    child: child,
  ),
);
