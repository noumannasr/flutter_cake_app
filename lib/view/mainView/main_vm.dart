import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_images.dart';
import 'package:flutter_cake_app/model/cake_model.dart';
import 'package:flutter_cake_app/model/category_model.dart';
import 'package:flutter_cake_app/model/product_model.dart';

class MainVm extends ChangeNotifier {
  late BuildContext context;
  List<CategoryModel> _categories = [];
  bool _isLoading = true;
  final finalData = <String, List<ProductModel>>{};
  late Stream<Map<String, List<ProductModel>>> _categoriesAndProductsStream;

  bool get isLoading => _isLoading;
  Stream<Map<String, List<ProductModel>>> get categoriesAndProductsStream => _categoriesAndProductsStream;
  List<CategoryModel> get categories => _categories;

  MainVm(this.context) {
    print( ' We are here');
    mapCategoriesAndProducts();
    getCategoriesData();

  }

  setLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  // setCakeList(List<CakeModel> cakeList) {
  //   _cakes = cakeList;
  //   notifyListeners();
  // }

  Future<List<CategoryModel>> getCategoriesData() async {
    mapCategoriesAndProducts();
    setLoading(true);
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Categories').where('isActive', isEqualTo: false).get();

      for (var doc in querySnapshot.docs) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          final categoryModel = CategoryModel.fromMap(data);
          _categories.add(categoryModel);
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

    return _categories;
  }

  setStream() {
    _categoriesAndProductsStream = mapCategoriesAndProducts().asStream();
    notifyListeners();
    return _categoriesAndProductsStream;

  }

  Future<Map<String, List<ProductModel>>> mapCategoriesAndProducts() async {
    print( ' We are here');
    setLoading(true);
    final categoriesSnapshot = await FirebaseFirestore.instance.collection('Categories').get();
    final productsSnapshot = await FirebaseFirestore.instance.collection('Products').get();

    final categories = categoriesSnapshot.docs;
    final products = productsSnapshot.docs;



    categories.forEach((categoryDoc) {
      final filteredProducts = products.where((productDoc) => productDoc.data()['category'] == categoryDoc.data()['categoryName']).toList();
      final productModels = filteredProducts.map((productDoc) => ProductModel.fromFirestore(productDoc)).toList();
      finalData[categoryDoc.data()['categoryName']] = productModels;
      notifyListeners();
    });
    //final jsonData = jsonEncode(finalData);
    print(finalData.toString() + ' We are here');
    setLoading(false);
    return finalData;
  }

}
