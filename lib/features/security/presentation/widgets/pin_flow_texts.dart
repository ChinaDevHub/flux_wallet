import 'package:flux_wallet/features/security/presentation/cubit/pin_flow_state.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_prompt.dart';

String pinFlowTitle(PinFlowMode mode) => switch (mode) {
  PinFlowMode.create => 'PIN kodu qur',
  PinFlowMode.change => 'PIN-i dəyiş',
  PinFlowMode.remove => 'PIN-i sil',
};

String pinDoneMessage(PinFlowMode mode) => switch (mode) {
  PinFlowMode.create => 'PIN kodu quraşdırıldı',
  PinFlowMode.change => 'PIN kodu dəyişdirildi',
  PinFlowMode.remove => 'PIN kodu silindi',
};

/// What the pad says on each step of the flow.
PinPrompt pinStepPrompt(PinFlowState s, PinFlowMode mode) {
  final (title, subtitle) = switch (s.step) {
    PinFlowStep.current => (
      'Cari PIN kodu daxil et',
      mode == PinFlowMode.remove
          ? 'Silmək üçün indiki kodu təsdiqlə'
          : 'Dəyişmək üçün əvvəlcə indiki kodu təsdiqlə',
    ),
    PinFlowStep.enter => (
      'Yeni PIN kodu seç',
      'Yalnız sənin biləcəyin 4 və ya 6 rəqəm',
    ),
    PinFlowStep.confirm => (
      'PIN kodu təkrar daxil et',
      'Səhv olmadığına əmin olaq',
    ),
    PinFlowStep.done => ('Hazırdır', ''),
  };
  return PinPrompt(
    title: title,
    subtitle: subtitle,
    caption: s.error,
    captionError: true,
  );
}
