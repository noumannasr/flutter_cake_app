import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/widgets/material_button.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future<void> launchEmail({required String email}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': '',
        'body': '',
      },
    );

    launchURL(emailUri);
  }

  static Future<void> launchURL(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  static firebaseAnalyticsLogEvent(String event) {
    FirebaseAnalytics.instance.logEvent(name: event);
  }

  static Future<void> showVersionDialog({
    required BuildContext context,
    required VoidCallback onTap,
    required String title,
    required String subTitle,
    required String buttonTitle,
    bool? canPop,
    bool? barrierDismissible,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext context) {
        // String title = "New Update Available";
        // String message =
        //     "There is a newer version of app available please update it now.";
        // String btnLabel = "Update Now";

        return PopScope(
          canPop: canPop ?? false,
          child: AlertDialog(
            title: Text(title),
            content: Text(subTitle),
            actions: [
              MyButton(
                title: buttonTitle,
                onTap: onTap,
              ),
            ],
          ),
        );
      },
    );
  }
}
