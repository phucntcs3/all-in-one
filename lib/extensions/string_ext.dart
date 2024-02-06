extension StringX on String {
  double toDouble() {
    return double.tryParse(this) ?? double.nan;
  }
}
