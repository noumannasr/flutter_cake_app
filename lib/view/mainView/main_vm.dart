import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_images.dart';
import 'package:flutter_cake_app/model/cake_model.dart';

class MainVm extends ChangeNotifier {
  late BuildContext context;
  List<CakeModel> _cakes = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  List<CakeModel> get cakes => _cakes;

  MainVm(this.context) {
    getCakeData();
  }

  setLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  // setCakeList(List<CakeModel> cakeList) {
  //   _cakes = cakeList;
  //   notifyListeners();
  // }

  Future<List<CakeModel>> getCakeData() async {
    setLoading(true);
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('CakeRecipes').where('isActive', isEqualTo: true).get();

      for (var doc in querySnapshot.docs) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          final cake = CakeModel.fromMap(data);
          _cakes.add(cake);
          notifyListeners();
        } catch (e) {
          // Handle data conversion errors or invalid data
          print('Error parsing cake data in model: $e');
          setLoading(false);
          // Consider logging the error or handling it differently
        }
      }
      Future.delayed(const Duration(milliseconds: 100));
      notifyListeners();
      setLoading(false);
    } catch (e) {
      // Handle data conversion errors or invalid data
      print('Error parsing cake data 2: $e');
      setLoading(false);
      // Consider logging the error or handling it differently
    }

    return _cakes;
  }
}
