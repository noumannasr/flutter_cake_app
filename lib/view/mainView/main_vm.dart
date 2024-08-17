import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/model/category_model.dart';
import 'package:flutter_cake_app/model/product_model.dart';
import 'package:flutter_cake_app/view/categories/categories_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MainVm extends ChangeNotifier {

  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  List<CategoryModel> _categories = [];
  List<ProductModel> _productsList = [];
  List<ProductModel> _filteredList = [];
  final finalData = <String, List<ProductModel>>{};
  late Stream<Map<String, List<ProductModel>>> _categoriesAndProductsStream;

  bool _isLoading = true;
  bool _isProductsLoading = true;

  bool get isLoading => _isLoading;
  bool get isProductsLoading => _isProductsLoading;
  Stream<Map<String, List<ProductModel>>> get categoriesAndProductsStream => _categoriesAndProductsStream;
  List<CategoryModel> get categories => _categories;
  List<ProductModel> get productsList => _productsList;
  List<ProductModel> get filteredList => _filteredList;

  MainVm(this.context) {
    init();
  }

  init() {
    print(' We are here');
    removeFocus();
    _categories.clear();
    _productsList.clear();
    _filteredList.clear();
    notifyListeners();
    mapCategoriesAndProducts();
    getProductsData();
    getCategoriesData();
  }

  setLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  void removeFocus() {
    // Unfocus the TextField programmatically
    focusNode.unfocus();
    notifyListeners();
  }

  setProductLoading(bool status) {
    _isProductsLoading = status;
    notifyListeners();
  }

  void updateFilteredList(String keyword) {
    if (searchController.text.isEmpty) {
      print('we are in clear');
      _filteredList.clear();
      removeFocus();
      notifyListeners();
    } else {
      print('we are in filtered');
      _filteredList = productsList
          .where((element) =>
              element.productName.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

  Future<List<CategoryModel>> getCategoriesData() async {
    mapCategoriesAndProducts();
    setLoading(true);
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Categories')
          .where('isActive', isEqualTo: true)
          .get();

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

  void getProductsData() async {
    setProductLoading(true);
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore
          .collection('Products')
          .where('isActive', isEqualTo: true)
          .get();
      final products = querySnapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc);
      }).toList();
      setProductList(products);
      setProductLoading(false);
      notifyListeners();
    } catch (e) {
      setProductLoading(false);
      // Handle data conversion errors or invalid data
      print('Error parsing products data 2: $e');
      // Consider logging the error or handling it differently
    }
  }

  setProductList(List<ProductModel> productsList) {
    _productsList = productsList;
    notifyListeners();
  }

  Future<Map<String, List<ProductModel>>> mapCategoriesAndProducts() async {
    print(' We are here');
    setLoading(true);
    final categoriesSnapshot =
        await FirebaseFirestore.instance.collection('Categories').get();
    final productsSnapshot =
        await FirebaseFirestore.instance.collection('Products').get();

    final categories = categoriesSnapshot.docs;
    final products = productsSnapshot.docs;

    categories.forEach((categoryDoc) {
      final filteredProducts = products
          .where((productDoc) =>
              productDoc.data()['category'] ==
              categoryDoc.data()['categoryName'])
          .toList();
      final productModels = filteredProducts
          .map((productDoc) => ProductModel.fromFirestore(productDoc))
          .toList();
      finalData[categoryDoc.data()['categoryName']] = productModels;
      notifyListeners();
    });
    //final jsonData = jsonEncode(finalData);
    print(finalData.toString() + ' We are here');
    setLoading(false);
    return finalData;
  }

  void onDrawerItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.of(context).pop();
        break;
      case 1:
        print('category Tap drawer');
        Navigator.of(context).push(
            PageRouteBuilder(
             pageBuilder: (context, animation, secondaryAnimation) => CategoriesView(),
             transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        ));
        break;
      case 2:
        Share.share('Your text here');
        print('Share Tap drawer');
        break;
      case 3:
        print('rate Tap drawer');
        break;
      case 4:
        print('More Tap drawer');
        break;
      case 5:
        launchEmail();
        print('Feedback Tap drawer');
        break;
      case 6:
        print('credit Tap drawer');
      case 7:
        print('privacy Tap drawer');
      case 8:
        print('version Tap drawer');
        break;
      default:
        print('default Tap drawer');
        break;
    }
  }

  void launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'developerzone3@gmail.com', // Replace with the recipient email
      queryParameters: {
        'subject': '', // Optional: set a default subject
        'body': '', // Optional: set default body
      },
    );

    // Check if the email client can be opened
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email client';
    }
  }
}
