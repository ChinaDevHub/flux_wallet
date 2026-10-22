import 'package:flutter/widgets.dart';

/// The Flux wallet glyph, drawn (not a font icon) so it is identical on
/// every platform. [ink] is the wallet, [cut] the tile behind it.
class WalletMarkPainter extends CustomPainter {
  const WalletMarkPainter({required this.ink, required this.cut});

  final Color ink, cut;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    RRect box(double l, double t, double r, double b, double radius) =>
        RRect.fromLTRBR(
          l * w,
          t * w,
          r * w,
          b * w,
          Radius.circular(radius * w),
        );
    Paint fill(Color color) => Paint()..color = color;
    canvas.drawRRect(box(.31, .26, .67, .34, .03), fill(ink.withAlpha(140)));
    canvas.drawRRect(box(.22, .33, .78, .72, .09), fill(ink));
    canvas.drawRRect(box(.485, .445, .835, .605, .08), fill(cut));
    canvas.drawRRect(box(.51, .47, .81, .58, .055), fill(ink));
    canvas.drawCircle(Offset(.6 * w, .525 * w), .024 * w, fill(cut));
  }

  @override
  bool shouldRepaint(WalletMarkPainter old) => old.ink != ink || old.cut != cut;
}
