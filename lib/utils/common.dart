import 'package:uuid/uuid.dart';

class CommonUtils {
  static String getRandomId() {
    Uuid uuid = const Uuid();
    return uuid.v4();
  }
}
