import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String toddMMyyyy() {
    return DateFormat('dd MMMM yyyy').format(this);
  }

  String toHHmm() {
    return DateFormat('HH:mm').format(this);
  }

  String toHHmmss() {
    return DateFormat('HH:mm:ss').format(this);
  }
}
