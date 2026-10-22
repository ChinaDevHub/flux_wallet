import 'package:flutter/services.dart';
import 'package:flux_wallet/core/widgets/app_input_decoration.dart';

/// What a text field is for: it decides keyboard, capitalisation and masking.
enum FieldKind {
  text,

  /// Names: each word starts with a capital.
  name,

  /// Logins: no auto-capitalisation, no autocorrect.
  username,
  decimal,
  integer,
  password;

  bool get isNumeric => this == decimal || this == integer;
  bool get isSecret => this == password;
  bool get autocorrects => this == text || this == name;

  TextCapitalization get capitalization =>
      this == name ? TextCapitalization.words : TextCapitalization.none;

  TextInputType get keyboard => isNumeric
      ? TextInputType.numberWithOptions(decimal: this == decimal)
      : TextInputType.text;

  List<TextInputFormatter>? get formatters =>
      isNumeric ? numericFormatters(integersOnly: this == integer) : null;
}
