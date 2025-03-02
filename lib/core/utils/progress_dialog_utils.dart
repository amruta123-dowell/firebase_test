import 'package:flutter/material.dart';

import 'navigator_service.dart';

class ProgressDialogUtils {
  static bool isProgressVisible = false;

  ///common method for showing progress dialog
  static void showProgressDialog(
      {BuildContext? context, isCancellable = false}) async {
    if (!isProgressVisible &&
        NavigatorClass.navigatorKey.currentState?.overlay?.context != null) {
      showDialog(
          barrierDismissible: isCancellable,
          context: NavigatorClass.navigatorKey.currentState!.overlay!.context,
          builder: (BuildContext context) {
            return PopScope(
                canPop: false,
                child: Center(
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ));
          });
      isProgressVisible = true;
    }
  }

  ///common method for hiding progress dialog
  static void hideProgressDialog() {
    if (isProgressVisible) {
      Navigator.pop(NavigatorClass.navigatorKey.currentState!.overlay!.context);
    }
    isProgressVisible = false;
  }
}
