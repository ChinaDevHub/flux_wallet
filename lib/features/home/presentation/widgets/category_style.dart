import 'package:flutter/material.dart';

class CategoryStyle {
  const CategoryStyle(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;

  static const _styles = {
    'taxi': CategoryStyle('Taksi', Icons.local_taxi_rounded, Color(0xFF3B8E74)),
    'bus': CategoryStyle(
      'Avtobus',
      Icons.directions_bus_rounded,
      Color(0xFF3B8E74),
    ),
    'grocery': CategoryStyle(
      'Ərzaq',
      Icons.shopping_cart_rounded,
      Color(0xFFC8643C),
    ),
    'cafe': CategoryStyle('Kafe', Icons.local_cafe_rounded, Color(0xFF8A6BC8)),
    'rent': CategoryStyle('Kirayə', Icons.home_rounded, Color(0xFFC8643C)),
    'debt': CategoryStyle('Borc', Icons.handshake_rounded, Color(0xFF5B6FD6)),
    'utilities': CategoryStyle(
      'Kommunal',
      Icons.bolt_rounded,
      Color(0xFFD9A21B),
    ),
    'fuel': CategoryStyle(
      'Yanacaq',
      Icons.local_gas_station_rounded,
      Color(0xFF6B7B86),
    ),
    'salary': CategoryStyle('Maaş', Icons.payments_rounded, Color(0xFF2E7D5B)),
  };

  static const _other = CategoryStyle(
    'Digər',
    Icons.more_horiz_rounded,
    Color(0xFF7A8580),
  );

  static CategoryStyle of(String category) => _styles[category] ?? _other;
}
