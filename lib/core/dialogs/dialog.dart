import 'package:flutter/material.dart';

class CustomDialog {
  static showCustomDialog({
    required BuildContext context,
    required Widget dialogWidget,
    bool? barrierDismissible,
    bool? canPop,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: canPop ?? false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 5.0,
            backgroundColor: Colors.white,
            child: dialogWidget,
          ),
        );
      },
    );
  }
}
