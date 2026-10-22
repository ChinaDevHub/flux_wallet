import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/platform_icon.dart';

/// Things a button does.
abstract final class ActionIcons {
  static IconData get add =>
      platformIcon(Icons.add_rounded, CupertinoIcons.add);
  static IconData get addCircle => platformIcon(
    Icons.add_circle_outline_rounded,
    CupertinoIcons.add_circled,
  );
  static IconData get edit =>
      platformIcon(Icons.edit_rounded, CupertinoIcons.pencil);
  static IconData get editNote =>
      platformIcon(Icons.edit_note_rounded, CupertinoIcons.square_pencil);
  static IconData get delete =>
      platformIcon(Icons.delete_outline_rounded, CupertinoIcons.trash);
  static IconData get check =>
      platformIcon(Icons.check_rounded, CupertinoIcons.check_mark);
  static IconData get undo =>
      platformIcon(Icons.undo_rounded, CupertinoIcons.arrow_uturn_left);
  static IconData get repeat =>
      platformIcon(Icons.repeat_rounded, CupertinoIcons.repeat);
  static IconData get exportFile =>
      platformIcon(Icons.upload_file_rounded, CupertinoIcons.square_arrow_up);
  static IconData get importFile =>
      platformIcon(Icons.download_rounded, CupertinoIcons.square_arrow_down);
}
