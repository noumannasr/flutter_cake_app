import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/model/drawer_model.dart';
import 'package:flutter_cake_app/utils/base_env.dart';
import 'package:flutter_cake_app/utils/extensions.dart';

class AppDrawerList {
  static List<DrawerModel> drawerList = [
    DrawerModel(
        name: 'home'.tr(), appDrawerEnum: AppDrawerEnum.home, icon: Icons.home),
    DrawerModel(
        name: 'language'.tr(),
        appDrawerEnum: AppDrawerEnum.language,
        icon: Icons.language),
    DrawerModel(
        name: 'categories'.tr(),
        appDrawerEnum: AppDrawerEnum.categories,
        icon: Icons.category),
    DrawerModel(
        name: 'share_app'.tr(),
        appDrawerEnum: AppDrawerEnum.shareApp,
        icon: Icons.share),
    DrawerModel(
        name: 'rate_app'.tr(),
        appDrawerEnum: AppDrawerEnum.rateApp,
        icon: Icons.star_rate),
    DrawerModel(
        name: 'more_apps'.tr(),
        appDrawerEnum: AppDrawerEnum.moreApps,
        icon: Icons.menu),
    DrawerModel(
        name: BaseEnv.instance.status.appFlavor() == AppFlavorEnum.free
            ? 'feedback_us'.tr()
            : 'helpAndSupport'.tr(),
        appDrawerEnum: AppDrawerEnum.feedbackUs,
        icon: Icons.feedback),
    DrawerModel(
        name: 'creditAttribution'.tr(),
        appDrawerEnum: AppDrawerEnum.creditAttribution,
        icon: Icons.attribution),
    DrawerModel(
        name: 'privacy_policy'.tr(),
        appDrawerEnum: AppDrawerEnum.privacyPolicy,
        icon: Icons.privacy_tip),
    DrawerModel(
      name: 'remove_ads'.tr(),
      appDrawerEnum: AppDrawerEnum.removeAds,
      icon: Icons.remove_circle_outline_sharp,
      hideItem: BaseEnv.instance.status.appFlavor() == AppFlavorEnum.free
          ? false
          : true,
    ),
    DrawerModel(
        name: 'app_version'.tr(),
        appDrawerEnum: AppDrawerEnum.appVersion,
        icon: Icons.info),
  ];
}

enum AppDrawerEnum {
  home,
  language,
  categories,
  shareApp,
  rateApp,
  moreApps,
  feedbackUs,
  creditAttribution,
  privacyPolicy,
  removeAds,
  appVersion,
}
