import 'package:flutter_cake_app/utils/app_config.dart';
import 'package:flutter_cake_app/utils/base_env.dart';
import 'package:flutter_cake_app/utils/extensions.dart';

class AppText {
  static String freeAppName = 'RecipeTreasure: Cook Guide';
  static String paidAppName = 'RecipeTreasure: Cook Guide Pro';
  static const supportEmail = "support@developerzonne.com";
  static const developerAccountId = "Developer+Zonne";
  static String appLink =
      "https://play.google.com/store/apps/details?id=${AppConfig().packageInfo.packageName}";
  static const moreApps =
      "https://play.google.com/store/apps/developer?id=$developerAccountId";
  static const privacyPolicyPageUrl =
      "https://tastyrecipies.developerzonne.com/privacy-policy.html";
  static const iconsAttributionPageUrl =
      'https://tastyrecipies.developerzonne.com/attribution-credit.html';
  static String shareText =
      'Transform your cooking with our easy-to-follow recipes using ${BaseEnv.instance.status.appFlavorName()}! Download now $appLink';
  static String appVersionFreeRemoteConfig = 'app_version_free';
  static String appVersionPaidRemoteConfig = 'app_version_paid';
  static const paidAppUrl =
      'https://play.google.com/store/apps/details?id=com.deliciousandtastyrecipes.app.premium';
}
