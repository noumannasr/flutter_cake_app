import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/constants/app_drawer_list.dart';
import 'package:flutter_cake_app/constants/logs_events_keys.dart';
import 'package:flutter_cake_app/core/services/my_shared_preferences.dart';
import 'package:flutter_cake_app/model/drawer_model.dart';
import 'package:flutter_cake_app/utils/app_config.dart';
import 'package:flutter_cake_app/utils/base_env.dart';
import 'package:flutter_cake_app/utils/extensions.dart';
import 'package:flutter_cake_app/utils/utils.dart';
import 'package:flutter_cake_app/view/mainView/main_vm.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<DrawerModel> drawerList = [
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

  @override
  void initState() {
    Utils.firebaseAnalyticsLogEvent(drawerScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  AppColors.secondaryColor,
                  AppColors.primaryColor,
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      BaseEnv.instance.status.appFlavorIcon(),
                    ),
                    radius: 40,
                  ),
                ),
                Text(
                  BaseEnv.instance.status.appFlavorName(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemCount:drawerList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final item = drawerList[index];
              return item.hideItem == true
                  ? IgnorePointer()
                  : Consumer<MainVm>(
                      builder: (context, mainVm, child) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Icon(item.icon),
                              title: Text(item.name),
                              trailing: item.appDrawerEnum ==
                                      AppDrawerEnum.language
                                  ? Text('${MySharedPreference.getLang()}')
                                  : item.appDrawerEnum ==
                                          AppDrawerEnum.appVersion
                                      ? Text(
                                          '${AppConfig().packageInfo.version}')
                                      : Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                        ),
                              onTap: () {
                                mainVm.onDrawerItemTapped(
                                    item.appDrawerEnum, context);
                              },
                              dense: false,
                              minVerticalPadding: 0.0,
                              minTileHeight: 40,
                            ),
                            Divider(),
                          ],
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
