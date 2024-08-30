import 'package:flutter_cake_app/constants/app_images.dart';
import 'package:flutter_cake_app/constants/app_texts.dart';

enum AppFlavorEnum {
  paid,
  free,
}

extension BaseEnvExten on String {
  String appFlavorType() {
    switch (this) {
      case 'free':
        return '';
      case 'paid':
        return 'Premium';
      default:
        return '';
    }
  }

  AppFlavorEnum appFlavor() {
    switch (this) {
      case 'free':
        return AppFlavorEnum.free;
      case 'paid':
        return AppFlavorEnum.paid;
      default:
        return AppFlavorEnum.free;
    }
  }

  String appFlavorName() {
    switch (this) {
      case 'free':
        return AppText.freeAppName;
      case 'paid':
        return AppText.paidAppName;
      default:
        return AppText.freeAppName;
    }
  }

  String appFlavorIcon() {
    switch (this) {
      case 'free':
        return AppImages.freeAppIcon;
      case 'paid':
        return AppImages.paidAppIcon;
      default:
        return AppImages.freeAppIcon;
    }
  }

  String remoteConfigFlavorAppVersionKey() {
    switch (this) {
      case 'free':
        return AppText.appVersionFreeRemoteConfig;
      case 'paid':
        return AppText.appVersionPaidRemoteConfig;
      default:
        return AppText.appVersionFreeRemoteConfig;
    }
  }

  String pushNotificationFlavorIcon() {
    switch (this) {
      case 'free':
        return '@drawable/free_flavor_app_icon';
      case 'paid':
        return '@drawable/paid_flavor_app_icon';
      default:
        return '@drawable/free_flavor_app_icon';
    }
  }
}
