/// "28 saniyə", "4:59 dəqiqə", "1:00:00 saat".
String waitText(int seconds) {
  String two(int n) => n.toString().padLeft(2, '0');
  final h = seconds ~/ 3600, m = seconds % 3600 ~/ 60, s = seconds % 60;
  if (h > 0) return '$h:${two(m)}:${two(s)} saat';
  if (m > 0) return '$m:${two(s)} dəqiqə';
  return '$s saniyə';
}
