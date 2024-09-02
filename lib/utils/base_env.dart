import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseEnv {
  BaseEnv._internal();

  static final BaseEnv _instance = BaseEnv._internal();

  static BaseEnv get instance => _instance;

  late String _status;
  late String _products;
  late String _categories;

  void setEnv() {
    _status = dotenv.env['APP_STATUS'] ?? '';
    _products = dotenv.env['PRODUCTS'] ?? '';
    _categories = dotenv.env['CATEGORIES'] ?? '';
  }

  String get status => _status;
  String get products => _products;
  String get categories => _categories;
}
