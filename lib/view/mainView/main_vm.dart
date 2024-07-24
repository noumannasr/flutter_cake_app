import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_images.dart';
import 'package:flutter_cake_app/model/cake_model.dart';

class MainVm extends ChangeNotifier {
  static List<CakeModel> cakes = [
    CakeModel('Mango Cake', AppImages.mangoCake, 'Cocking time 15 minutes',
        'Soft Cake'),
    CakeModel('Red Velvet Cake', AppImages.redVelvetCake,
        'Cocking time 11 minutes', 'Soft Cake'),
    CakeModel('Carrot Cake', AppImages.carrotCake, 'Cocking time 9 minutes',
        'Soft Cake'),
    CakeModel('Fruit Cake', AppImages.fruitCake, 'Cocking time 10 minutes',
        'Soft Cake'),
    CakeModel('Choclate Cake', AppImages.choclateCake, 'Cocking time 8 minutes',
        'Soft Cake'),
  ];


}

