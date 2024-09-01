import 'package:flutter/material.dart';
import 'package:flutter_cake_app/model/drawer_model.dart';
import 'package:flutter_cake_app/utils/base_env.dart';
import 'package:flutter_cake_app/utils/extensions.dart';

class AppDrawerList {
  static List<DrawerModel> drawerList = [
    DrawerModel(
        name: 'Home', appDrawerEnum: AppDrawerEnum.home, icon: Icons.home),
    DrawerModel(
        name: 'Language', appDrawerEnum: AppDrawerEnum.language, icon: Icons.language),
    DrawerModel(
        name: 'Categories',
        appDrawerEnum: AppDrawerEnum.categories,
        icon: Icons.category),
    DrawerModel(
        name: 'Share App',
        appDrawerEnum: AppDrawerEnum.shareApp,
        icon: Icons.share),
    DrawerModel(
        name: 'Rate App',
        appDrawerEnum: AppDrawerEnum.rateApp,
        icon: Icons.star_rate),
    DrawerModel(
        name: 'More Apps',
        appDrawerEnum: AppDrawerEnum.moreApps,
        icon: Icons.menu),
    DrawerModel(
        name: BaseEnv.instance.status.appFlavor() == AppFlavorEnum.free
            ? 'Feedback Us'
            : 'Help & Support',
        appDrawerEnum: AppDrawerEnum.feedbackUs,
        icon: Icons.feedback),
    DrawerModel(
        name: 'Credit - Attribution',
        appDrawerEnum: AppDrawerEnum.creditAttribution,
        icon: Icons.attribution),
    DrawerModel(
        name: 'Privacy Policy',
        appDrawerEnum: AppDrawerEnum.privacyPolicy,
        icon: Icons.privacy_tip),
    DrawerModel(
      name: 'Remove Ads',
      appDrawerEnum: AppDrawerEnum.removeAds,
      icon: Icons.remove_circle_outline_sharp,
      hideItem: BaseEnv.instance.status.appFlavor() == AppFlavorEnum.free
          ? false
          : true,
    ),
    DrawerModel(
        name: 'App Version',
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
