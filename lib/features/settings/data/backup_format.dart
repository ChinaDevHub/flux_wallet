import 'dart:convert';

import 'package:flux_wallet/core/database/db_migrations.dart';
import 'package:flux_wallet/features/settings/domain/entities/backup_exception.dart';

const backupApp = 'flux_wallet';

String encodeBackup(
  Map<String, List<Map<String, Object?>>> tables,
  DateTime at,
) => const JsonEncoder.withIndent('  ').convert({
  'app': backupApp,
  'schema': migrations.length,
  'exportedAt': at.toIso8601String(),
  'tables': tables,
});

/// Table name -> rows, after checking it is one of ours and not from a newer app.
Map<String, List<Map<String, Object?>>> decodeBackup(String json) {
  final Object? data;
  try {
    data = jsonDecode(json);
  } on FormatException {
    throw const BackupException('Fayl JSON deyil');
  }
  if (data is! Map || data['app'] != backupApp || data['tables'] is! Map) {
    throw const BackupException('Bu Flux Wallet ehtiyat nüsxəsi deyil');
  }
  if ((data['schema'] as int? ?? 0) > migrations.length) {
    throw const BackupException(
      'Ehtiyat nüsxəsi tətbiqin daha yeni versiyasındandır',
    );
  }
  return {
    for (final e in (data['tables'] as Map).entries)
      e.key as String: [
        for (final row in e.value as List)
          Map<String, Object?>.from(row as Map),
      ],
  };
}
