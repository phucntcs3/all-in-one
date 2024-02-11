extension DurationX on Duration {
  String toHHmm() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitHours = twoDigits(inHours.remainder(24));

    return "$twoDigitHours:$twoDigitMinutes";
  }

  String toHHmmss() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitHours = twoDigits(inHours.remainder(24));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));

    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }
}
