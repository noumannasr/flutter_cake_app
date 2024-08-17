import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/constants/app_drawer_list.dart';
import 'package:flutter_cake_app/constants/app_images.dart';
import 'package:flutter_cake_app/view/mainView/main_vm.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
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
                    ])),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(AppImages.appIcon),
                    radius: 40,
                  ),
                ),
                Text(
                  "Delicious & Tasty Recipes",
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
              itemCount: AppDrawerList().drawerList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final item = AppDrawerList().drawerList[index];
                return Consumer<MainVm>(
                  builder: (context, mainVm, child) {
                    return Column(
                      children: [
                        ListTile(

                          leading: Icon(item.icon),
                          title: Text(item.name),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),

                          onTap: () {
                           mainVm.onDrawerItemTapped(index, context);
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
              }),

        ],
      ),
    );
  }
}
