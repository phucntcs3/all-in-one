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

  String toHHmmssLocale() {
    String hours =
        inHours > 0 ? '$inHours ${inHours == 1 ? 'hour' : 'hours'}' : '';

    String minutes = inMinutes.remainder(60) > 0
        ? '${inMinutes.remainder(60)} ${inMinutes.remainder(60) == 1 ? 'minute' : 'minutes'}'
        : '';
    String seconds = inSeconds.remainder(60) > 0
        ? '${inSeconds.remainder(60)} ${inSeconds.remainder(60) == 1 ? 'second' : 'seconds'}'
        : '';

    String formattedDuration =
        '$hours${hours.isNotEmpty && (minutes.isNotEmpty || seconds.isNotEmpty) ? ',' : ''} $minutes${minutes.isNotEmpty && seconds.isNotEmpty ? ',' : ''} $seconds';
    return formattedDuration.trim();
  }
}
