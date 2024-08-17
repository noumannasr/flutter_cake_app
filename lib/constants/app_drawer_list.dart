import 'package:flutter/material.dart';
import 'package:flutter_cake_app/model/drawer_model.dart';

class AppDrawerList {
  List<DrawerModel> drawerList = [
    DrawerModel(name: 'Home', icon: Icons.home),
    DrawerModel(name: 'Categories', icon: Icons.category),
    DrawerModel(name: 'Share App', icon: Icons.share),
    DrawerModel(name: 'Rate App', icon: Icons.star_rate),
    DrawerModel(name: 'More Apps', icon: Icons.menu),
    DrawerModel(name: 'Feedback us', icon: Icons.feedback),
    DrawerModel(name: 'Credit - Attribution', icon: Icons.attribution),
    DrawerModel(name: 'Privacy Policy', icon: Icons.privacy_tip),
    DrawerModel(name: 'App Version', icon: Icons.info),
  ];
}
