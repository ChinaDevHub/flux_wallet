import 'package:flutter/animation.dart';

/// Plays the splash [timeline] and reports its two milestones: the logo has
/// landed ([onSettled]) and everything has played ([onFinished]).
class SplashDirector {
  SplashDirector(
    this.timeline, {
    required this.onSettled,
    required this.onFinished,
  });

  final AnimationController timeline;
  final VoidCallback onSettled, onFinished;
  bool _settled = false;

  /// [instant] jumps to the end (the user asked the system to reduce motion).
  Future<void> play({required bool instant}) async {
    // Callbacks change the parent's state, which must not happen mid-build.
    await Future<void>.delayed(Duration.zero);
    timeline.addListener(_checkSettled);
    if (instant) timeline.value = 1;
    await timeline.forward();
    await Future<void>.delayed(const Duration(milliseconds: 250));
    onFinished();
  }

  void _checkSettled() {
    if (_settled || timeline.value < 0.45) return;
    _settled = true;
    onSettled();
  }
}
