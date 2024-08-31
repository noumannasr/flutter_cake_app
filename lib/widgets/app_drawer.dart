import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/constants/app_drawer_list.dart';
import 'package:flutter_cake_app/constants/logs_events_keys.dart';
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
            itemCount: AppDrawerList.drawerList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final item = AppDrawerList.drawerList[index];
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
                                      AppDrawerEnum.appVersion
                                  ? Text('${AppConfig().packageInfo.version}')
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
