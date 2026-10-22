import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flux_wallet/features/settings/domain/repositories/backup_gateway.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Native share sheet out, native file picker in.
class FileBackupGateway implements BackupGateway {
  const FileBackupGateway();

  @override
  Future<void> shareFile(String fileName, String contents) async {
    final dir = await getTemporaryDirectory();
    final file = await File('${dir.path}/$fileName').writeAsString(contents);
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }

  @override
  Future<String?> pickFile() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json'],
    );
    if (files.isEmpty) return null;
    return utf8.decode(await files.first.readAsBytes());
  }
}
