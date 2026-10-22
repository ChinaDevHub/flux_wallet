/// What the user has chosen so far for one pending item.
class ApprovalDraft {
  const ApprovalDraft({this.category, this.replaceBus, this.remember = true});

  final String? category;

  /// Null until the "does this taxi replace the bus?" question is answered.
  final bool? replaceBus;
  final bool remember;

  ApprovalDraft copyWith({
    String? category,
    bool? replaceBus,
    bool? remember,
  }) => ApprovalDraft(
    category: category ?? this.category,
    replaceBus: replaceBus ?? this.replaceBus,
    remember: remember ?? this.remember,
  );
}
