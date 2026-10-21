import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/category_style.dart';

/// Label, icon and tint per category id.
const categoryStyles = {
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
  'utilities': CategoryStyle('Kommunal', Icons.bolt_rounded, Color(0xFFD9A21B)),
  'fuel': CategoryStyle(
    'Yanacaq',
    Icons.local_gas_station_rounded,
    Color(0xFF6B7B86),
  ),
  'gift': CategoryStyle(
    'Hədiyyə',
    Icons.card_giftcard_rounded,
    Color(0xFFB04A8F),
  ),
  'repayment': CategoryStyle('Qaytarma', Icons.undo_rounded, Color(0xFF2E7D5B)),
  'salary': CategoryStyle('Maaş', Icons.payments_rounded, Color(0xFF2E7D5B)),
};

const fallbackCategoryStyle = CategoryStyle(
  'Digər',
  Icons.more_horiz_rounded,
  Color(0xFF7A8580),
);
