import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

class DebugUtils {
  static void printJson(dynamic json) {
    if (kDebugMode) {
      try {
        final spaces = ' ' * 3;
        final encoder = JsonEncoder.withIndent(spaces);

        final result = encoder.convert(json);

        final frame = Frame.caller(1);
        final filePath = frame
            .toString()
            .split('/')
            .sublist(1)
            .join('/')
            .split(' in ')
            .first
            .split(' ')
            .join(' at line ');
        debugPrint('%% $result\t\t(lib/$filePath)');
      } catch (e) {
        debugPrint('CANNOT PRINT ${json.runtimeType} type');
      }
    }
  }

  static void printDebug(dynamic data) {
    if (kDebugMode) {
      try {
        final frame = Frame.caller(1);
        final filePath = frame
            .toString()
            .split('/')
            .sublist(1)
            .join('/')
            .split(' in ')
            .first
            .split(' ')
            .join(' at line ');

        debugPrint('$data\t\t(lib/$filePath)');
      } catch (e) {
        //
      }
    }
  }
}
