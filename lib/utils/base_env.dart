import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseEnv {
  BaseEnv._internal();

  static final BaseEnv _instance = BaseEnv._internal();

  static BaseEnv get instance => _instance;

  late String _status;

  void setEnv() {
    _status = dotenv.env['APP_STATUS'] ?? '';
  }

  String get status => _status;
}
