import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_ads_ids.dart';
import 'package:flutter_cake_app/constants/app_drawer_list.dart';
import 'package:flutter_cake_app/constants/app_texts.dart';
import 'package:flutter_cake_app/core/dialogs/dialog.dart';
import 'package:flutter_cake_app/model/category_model.dart';
import 'package:flutter_cake_app/model/product_model.dart';
import 'package:flutter_cake_app/utils/base_env.dart';
import 'package:flutter_cake_app/utils/extensions.dart';
import 'package:flutter_cake_app/utils/utils.dart';
import 'package:flutter_cake_app/view/categories/categories_view.dart';
import 'package:flutter_cake_app/view/mainView/main_view.dart';
import 'package:flutter_cake_app/widgets/material_button.dart';
import 'package:flutter_cake_app/widgets/upgrade_premium_version_dialog_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  Stream<Map<String, List<ProductModel>>> get categoriesAndProductsStream =>
      _categoriesAndProductsStream;

  List<CategoryModel> get categories => _categories;

  List<ProductModel> get productsList => _productsList;

  List<ProductModel> get filteredList => _filteredList;

  MainVm(this.context) {
    init();
  }

  void init() {
    removeFocus();
    _categories.clear();
    _productsList.clear();
    _filteredList.clear();
    notifyListeners();
    mapCategoriesAndProducts();
    getProductsData();
    getCategoriesData();
    notifyListeners();
  }

  Future<void> refreshData() async {
    // Simulate a network call or data refresh
    print(' We are in refresh data');
    await Future.delayed(Duration(seconds: 1));
    removeFocus();
    _categories.clear();
    _productsList.clear();
    _filteredList.clear();
    notifyListeners();
    getCategoriesData();
    getProductsData();
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
    final categoriesSnapshot = await FirebaseFirestore.instance
        .collection('Categories')
        .where('isActive', isEqualTo: true)
        .get();
    final productsSnapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('isActive', isEqualTo: true)
        .get();

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

  void onDrawerItemTapped(AppDrawerEnum appDrawerEnum, BuildContext context) {
    switch (appDrawerEnum) {
      case AppDrawerEnum.home:
        AppAdsIds.showInterstitialAd(
          navigationEnum: NavigationScreensEnum.onPop,
          context: context,
        );
        break;
      case AppDrawerEnum.categories:

        ///* category Tap drawer
        Navigator.of(context).pop();

        AppAdsIds.showInterstitialAd(
          navigationEnum: NavigationScreensEnum.seeAllCategories,
          context: context,
        );
        break;
      case AppDrawerEnum.shareApp:
        Navigator.of(context).pop();

        ///* share tap drawer
        Share.share(AppText.shareText);
        break;
      case AppDrawerEnum.rateApp:
        Navigator.of(context).pop();

        ///* rate App
        Utils.launchURL(Uri.parse(AppText.appLink));
        break;
      case AppDrawerEnum.moreApps:
        Navigator.of(context).pop();

        ///* more apps
        Utils.launchURL(Uri.parse(AppText.moreApps));
        break;
      case AppDrawerEnum.feedbackUs:
        Navigator.of(context).pop();

        ///* feedback us
        Utils.launchEmail(
            email: AppText.supportEmail,
            subject: BaseEnv.instance.status.supportEmailTitle());
        break;
      case AppDrawerEnum.creditAttribution:
        Navigator.of(context).pop();

        ///* credit attribution
        Utils.launchURL(Uri.parse(AppText.iconsAttributionPageUrl));
      case AppDrawerEnum.privacyPolicy:
        Navigator.of(context).pop();

        ///* privacy policy
        Utils.launchURL(Uri.parse(AppText.privacyPolicyPageUrl));
      case AppDrawerEnum.removeAds:
        Navigator.of(context).pop();

        CustomDialog.showCustomDialog(
          context: context,
          canPop: true,
          barrierDismissible: true,
          dialogWidget: UpgradePremiumVersionDialogWidget(),
        );
        break;
      default:
        print('default Tap drawer');
        break;
    }
  }
}
