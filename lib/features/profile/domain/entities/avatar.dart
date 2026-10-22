/// How `User.avatarUrl` is read: a built-in preset or a picked photo.
abstract final class Avatar {
  static const _presetPrefix = 'preset:';
  static const _filePrefix = 'file:';

  static String preset(int index) => '$_presetPrefix$index';
  static String file(String name) => '$_filePrefix$name';

  static int? presetIndex(String? url) =>
      url != null && url.startsWith(_presetPrefix)
      ? int.tryParse(url.substring(_presetPrefix.length))
      : null;

  static String? fileName(String? url) =>
      url != null && url.startsWith(_filePrefix)
      ? url.substring(_filePrefix.length)
      : null;
}
