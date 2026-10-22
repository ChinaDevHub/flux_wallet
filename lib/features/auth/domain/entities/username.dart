/// "  Rauf.Aliyev " and "rauf.aliyev" are the same account.
String normalizeUsername(String raw) => raw.trim().toLowerCase();

final _allowed = RegExp(r'^[a-z0-9._]{3,24}$');

bool isValidUsername(String normalized) => _allowed.hasMatch(normalized);
