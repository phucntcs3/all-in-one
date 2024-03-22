import 'package:aio_mobile/app.dart';
import 'package:flutter/material.dart';

class AppSize {
  static const double inputHeight = 45;
}

var shortestSide =
    MediaQuery.of(navigatorKey.currentContext!).size.shortestSide;

// Determine if we should use mobile layout or not, 600 here is
// a common breakpoint for a typical 7-inch tablet.
final bool isMobile = shortestSide < 600;
