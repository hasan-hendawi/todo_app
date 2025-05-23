import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/generated/locale_keys.g.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (buildContext) => AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 12,
                  ),
                  Text(LocaleKeys.loading.tr())
                ],
              ),
            ),
        barrierDismissible: false);
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(BuildContext context,
      {required String message,
      String? postActionName,
      String? negActionName,
      VoidCallback? postAction,
      VoidCallback? negAction,
      bool diss = true}) {
    List<Widget> actions = [];
    if (postActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            postAction?.call();
          },
          child: Text(postActionName)));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionName)));
    }
    showDialog(
        context: context,
        builder: (buildContext) => AlertDialog(
              content: Text(message),
              actions: actions,
            ),
        barrierDismissible: diss);
  }
}
