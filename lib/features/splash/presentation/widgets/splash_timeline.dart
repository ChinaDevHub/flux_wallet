import 'package:flutter/animation.dart';

/// The part of the splash [timeline] between [begin] and [end] (0..1 of the
/// whole), eased by [curve]. Every element animates its own slice.
Animation<double> span(
  Animation<double> timeline,
  double begin,
  double end, [
  Curve curve = Curves.linear,
]) => timeline.drive(CurveTween(curve: Interval(begin, end, curve: curve)));
