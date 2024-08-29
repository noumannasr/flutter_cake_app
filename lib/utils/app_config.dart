import 'package:package_info_plus/package_info_plus.dart';

class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();

  late PackageInfo _packageInfo;

  PackageInfo get packageInfo => _packageInfo;

  Future<void> setPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }
}
