import 'dart:ui';

/// The manat sign (₼), drawn as strokes: an "m" with a tall middle stem.
/// [s] is the side of the square it is drawn in; it is centred in it and
/// takes up its middle third.
Path manatPath(double s) {
  final left = s * 0.33, mid = s * 0.5, right = s * 0.67;
  final bottom = s * 0.65, archBase = s * 0.535, top = s * 0.36;
  final arch = Radius.circular(s * 0.085);
  return Path()
    ..moveTo(left, bottom)
    ..lineTo(left, archBase)
    ..arcToPoint(Offset(mid, archBase), radius: arch)
    ..lineTo(mid, bottom)
    ..moveTo(mid, archBase)
    ..arcToPoint(Offset(right, archBase), radius: arch)
    ..lineTo(right, bottom)
    ..moveTo(mid, archBase)
    ..lineTo(mid, top);
}
