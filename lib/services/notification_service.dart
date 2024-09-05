import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> notificationServiceSnackBarKey =
    GlobalKey<ScaffoldMessengerState>();

class NotificationService {
  static void notify(
    String message, {
    String? htmlContent,
    TextAlign? textAlign,
    TextStyle? textStyle,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 5),
    Duration actionDuration = const Duration(seconds: 10),
    bool removeCurrentSnackBar = false,
  }) async {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: textAlign ?? TextAlign.center,
        style: textStyle ??
            const TextStyle(
              fontWeight: FontWeight.w600,
            ),
      ),
      action: action,
      duration: action != null ? actionDuration : duration,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
    );
    if (removeCurrentSnackBar) {
      notificationServiceSnackBarKey.currentState?.removeCurrentSnackBar();
    }
    notificationServiceSnackBarKey.currentState?.showSnackBar(snackBar);
  }
}
