/// [borrowed]: I owe money (a mandatory expense). [lent]: someone owes me
/// (expected income that never counts towards the daily limit).
enum DebtDirection {
  borrowed('Borc aldım'),
  lent('Borc verdim');

  const DebtDirection(this.label);

  final String label;
}
