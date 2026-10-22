import 'package:flutter/painting.dart';

/// The Flux palette: fixed, so the logo looks the same in light and dark and
/// as a launcher icon.
const brandGreenLight = Color(0xFF2F8A70);
const brandGreen = Color(0xFF1B5E4B);
const brandCoin = Color(0xFFE9B949);
const brandInk = Color(0xFFFFFFFF);

const brandGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [brandGreenLight, brandGreen],
);
