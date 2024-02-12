extension StringX on String {
  double toDouble() {
    return double.tryParse(this) ?? double.nan;
  }

  Duration toDurationHHmmss() {
    List<String> parts = split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2].split('.')[0]); // Remove milliseconds

    Duration duration =
        Duration(hours: hours, minutes: minutes, seconds: seconds);

    return duration;
  }
}
