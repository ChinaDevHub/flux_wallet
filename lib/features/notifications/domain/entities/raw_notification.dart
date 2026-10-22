import 'package:equatable/equatable.dart';

/// A notification as the platform delivered it, before any parsing.
class RawNotification extends Equatable {
  const RawNotification({
    required this.text,
    required this.receivedAt,
    this.source,
  });

  final String text;
  final DateTime receivedAt;

  /// Package name of the app that posted it (Android).
  final String? source;

  @override
  List<Object?> get props => [text, receivedAt, source];
}
