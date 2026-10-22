import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// App-private folders. iOS may move the app container between launches, so
/// files are stored by name and resolved against today's folder.
class AppFiles {
  AppFiles._();

  static Directory? _documents;

  static Future<void> init() async =>
      _documents = await getApplicationDocumentsDirectory();

  static Directory get avatars {
    final root = _documents ?? (throw StateError('AppFiles.init() not called'));
    return Directory('${root.path}/avatars')..createSync(recursive: true);
  }

  static File avatar(String name) => File('${avatars.path}/$name');
}
