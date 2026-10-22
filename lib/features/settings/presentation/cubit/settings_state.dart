import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.reminderEnabled = false,
    this.accessSupported = false,
    this.accessGranted = false,
    this.pendingCount = 0,
  });

  final bool reminderEnabled;

  /// Only Android lets an app read other apps' notifications.
  final bool accessSupported, accessGranted;
  final int pendingCount;

  @override
  List<Object?> get props => [
    reminderEnabled,
    accessSupported,
    accessGranted,
    pendingCount,
  ];
}
