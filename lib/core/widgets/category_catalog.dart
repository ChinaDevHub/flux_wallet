import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/category_icons.dart';
import 'package:flux_wallet/core/widgets/category_style.dart';

/// Label, icon and tint per category id.
final categoryStyles = {
  'taxi': CategoryStyle('Taksi', CategoryIcons.taxi, Color(0xFF3B8E74)),
  'bus': CategoryStyle('Avtobus', CategoryIcons.bus, Color(0xFF3B8E74)),
  'grocery': CategoryStyle('Ərzaq', CategoryIcons.grocery, Color(0xFFC8643C)),
  'cafe': CategoryStyle('Kafe', CategoryIcons.cafe, Color(0xFF8A6BC8)),
  'rent': CategoryStyle('Kirayə', CategoryIcons.rent, Color(0xFFC8643C)),
  'debt': CategoryStyle('Borc', CategoryIcons.debt, Color(0xFF5B6FD6)),
  'utilities': CategoryStyle(
    'Kommunal',
    CategoryIcons.utilities,
    Color(0xFFD9A21B),
  ),
  'fuel': CategoryStyle('Yanacaq', CategoryIcons.fuel, Color(0xFF6B7B86)),
  'gift': CategoryStyle(
    'Hədiyyə / Bonus',
    CategoryIcons.gift,
    Color(0xFFB04A8F),
  ),
  'stipend': CategoryStyle(
    'Stipendiya',
    CategoryIcons.stipend,
    Color(0xFF3B6FD0),
  ),
  'repayment': CategoryStyle(
    'Qaytarma',
    CategoryIcons.repayment,
    Color(0xFF2E7D5B),
  ),
  'salary': CategoryStyle('Maaş', CategoryIcons.salary, Color(0xFF2E7D5B)),
};

final fallbackCategoryStyle = CategoryStyle(
  'Digər',
  CategoryIcons.other,
  Color(0xFF7A8580),
);
