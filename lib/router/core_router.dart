import 'package:aio_mobile/bloc/loading/loading_bloc.dart';
import 'package:aio_mobile/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app.dart';

class CoreRouter {
  static void pop([dynamic data]) {
    Navigator.of(navigatorKey.currentContext!).pop(data);
  }

  static Future<dynamic> push(Widget route) {
    return Navigator.of(navigatorKey.currentContext!).push(
      MaterialPageRoute(builder: (context) => route),
    );
  }

  static void pushReplacement(Widget route) {
    Navigator.of(navigatorKey.currentContext!).pushReplacement(
      MaterialPageRoute(builder: (context) => route),
    );
  }

  static Future<dynamic> showBottomSheet({
    required Widget Function(BuildContext) builder,
    Function? whenComplete,
  }) async {
    return showModalBottomSheet(
      context: navigatorKey.currentContext!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      backgroundColor: Colors.white,
      builder: builder,
    ).whenComplete(() {
      whenComplete?.call();
    });
  }

  static Route<dynamic>? onGenerateRoute(settings) {
    // bool isFirstTimeOpen =
    //     CoreStorage.instance.getBool(key: StorageKey.isFirstTimeOpen) ?? true;

    // bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
        // builder: (_) => const AgeFunc(),
      );
    }
    return null;
  }
}
