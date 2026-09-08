String formatPeso(double amount) {
  final String digits = amount.toStringAsFixed(0);
  final RegExp thousands = RegExp(r'(?=(\d{3})+(?!\d))');
  return '₱${digits.replaceAllMapped(thousands, (_) => ',')}';
}
