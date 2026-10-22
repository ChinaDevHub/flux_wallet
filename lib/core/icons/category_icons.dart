import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/platform_icon.dart';

/// One glyph per spending / income category.
abstract final class CategoryIcons {
  static IconData get taxi =>
      platformIcon(Icons.local_taxi_rounded, CupertinoIcons.car_fill);
  static IconData get bus =>
      platformIcon(Icons.directions_bus_rounded, CupertinoIcons.bus);
  static IconData get grocery =>
      platformIcon(Icons.shopping_cart_rounded, CupertinoIcons.cart_fill);
  static IconData get cafe =>
      platformIcon(Icons.local_cafe_rounded, CupertinoIcons.drop_fill);
  static IconData get rent =>
      platformIcon(Icons.home_rounded, CupertinoIcons.house);
  static IconData get debt =>
      platformIcon(Icons.handshake_rounded, CupertinoIcons.person_2);
  static IconData get utilities =>
      platformIcon(Icons.bolt_rounded, CupertinoIcons.bolt_fill);
  static IconData get fuel =>
      platformIcon(Icons.local_gas_station_rounded, CupertinoIcons.gauge);
  static IconData get gift =>
      platformIcon(Icons.card_giftcard_rounded, CupertinoIcons.gift);
  static IconData get repayment =>
      platformIcon(Icons.undo_rounded, CupertinoIcons.arrow_uturn_left);
  static IconData get salary =>
      platformIcon(Icons.payments_rounded, CupertinoIcons.money_dollar_circle);
  static IconData get other =>
      platformIcon(Icons.more_horiz_rounded, CupertinoIcons.ellipsis);
}
