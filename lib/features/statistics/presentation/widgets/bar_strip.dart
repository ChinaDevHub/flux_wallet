import 'package:flutter/material.dart';

/// The months side by side. Up to six share the card's width; more scroll
/// sideways, opening on the newest.
class BarStrip extends StatelessWidget {
  const BarStrip({super.key, required this.children});

  static const _fit = 6, _width = 46.0, _height = 146.0;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.length <= _fit) {
      return Row(children: [for (final c in children) Expanded(child: c)]);
    }
    return SizedBox(
      height: _height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        children: [
          for (final c in children.reversed) SizedBox(width: _width, child: c),
        ],
      ),
    );
  }
}
