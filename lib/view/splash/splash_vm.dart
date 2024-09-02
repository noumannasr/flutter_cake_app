import 'package:flutter/material.dart';
import 'package:flutter_cake_app/core/services/my_shared_preferences.dart';
import 'package:flutter_cake_app/view/languages/set_language_view.dart';
import 'package:flutter_cake_app/view/mainView/main_view.dart';

class SplashVm extends ChangeNotifier {
  bool _isFirstLogin = true;

  bool get isFirstLogin => _isFirstLogin;

  SplashVm(BuildContext context) {
    init(context);
  }

  init(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));

    _isFirstLogin = MySharedPreference.getIsFirstLogin();
    print(_isFirstLogin.toString() +
        _isFirstLogin.toString() +
        ' This is first login');

    if (_isFirstLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SetLanguageView()),
      ).whenComplete(() {
        MySharedPreference.setIsFirstLogin(false);
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainView()),
      );
    }
  }
}
