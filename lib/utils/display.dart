import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app.dart';
import '../bloc/loading/loading_bloc.dart';

class DisplayUtils {
  static showLoading() {
    navigatorKey.currentContext!.read<LoadingBloc>().add(
          const LoadingChanged(true),
        );
  }

  static hideLoading() {
    navigatorKey.currentContext!.read<LoadingBloc>().add(
          const LoadingChanged(false),
        );
  }

  static showSnackbar({
    String message = '',
    SnackbarStatus? snackbarStatus,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: getStatusColor(snackbarStatus),
    );

    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  }
}

enum SnackbarStatus {
  success,
  error,
  info,
}

Color getStatusColor(SnackbarStatus? status) {
  switch (status) {
    case SnackbarStatus.success:
      return Colors.green;
    case SnackbarStatus.error:
      return Colors.red;
    case SnackbarStatus.info:
      return Colors.blueAccent;
    default:
      return Colors.green;
  }
}
