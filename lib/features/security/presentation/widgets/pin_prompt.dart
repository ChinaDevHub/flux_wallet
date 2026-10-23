/// The words on a PIN screen: what to do, and how it went.
class PinPrompt {
  const PinPrompt({
    required this.title,
    this.subtitle,
    this.caption,
    this.captionError = false,
  });

  final String title;
  final String? subtitle;

  /// Under the dots: attempts left, cooldown, or a flow message.
  final String? caption;
  final bool captionError;
}
