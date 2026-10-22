import 'package:flutter/animation.dart';

/// Plays the splash [timeline]. When it has fully played the logo sits still
/// ([onSettled]: the app is built underneath now, where a slow frame cannot
/// be seen), and a moment later the splash may leave ([onFinished]).
class SplashDirector {
  SplashDirector(
    this.timeline, {
    required this.onSettled,
    required this.onFinished,
  });

  static const hold = Duration(milliseconds: 350);

  final AnimationController timeline;
  final VoidCallback onSettled, onFinished;

  /// [instant] jumps to the end (the user asked the system to reduce motion).
  Future<void> play({required bool instant}) async {
    // The callbacks change the parent's state: never in the middle of a build.
    await Future<void>.delayed(Duration.zero);
    if (instant) timeline.value = 1;
    await timeline.forward();
    onSettled();
    await Future<void>.delayed(hold);
    onFinished();
  }
}
