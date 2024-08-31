import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_drawer_list.dart';

class DrawerModel {
  final String name;
  final AppDrawerEnum appDrawerEnum;
  final IconData icon;
  final bool hideItem;

  DrawerModel({
    required this.name,
    required this.appDrawerEnum,
    required this.icon,
    this.hideItem = false,
  });
}
