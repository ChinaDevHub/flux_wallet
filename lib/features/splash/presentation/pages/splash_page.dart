import 'package:flutter/material.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_director.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_stage.dart';

/// The launch animation. [onSettled] fires once the logo has landed (the app
/// can start building underneath); [onFinished] when everything has played.
class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
    required this.onSettled,
    required this.onFinished,
  });

  final VoidCallback onSettled, onFinished;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final _timeline = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1900),
  );
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    SplashDirector(
      _timeline,
      onSettled: widget.onSettled,
      onFinished: () => mounted ? widget.onFinished() : null,
    ).play(instant: MediaQuery.disableAnimationsOf(context));
  }

  @override
  void dispose() {
    _timeline.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SplashStage(_timeline);
}
