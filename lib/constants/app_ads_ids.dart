import 'package:flutter/cupertino.dart';
import 'package:flutter_cake_app/adService/interstitial_ad_singleton.dart';
import 'package:flutter_cake_app/model/product_model.dart';
import 'package:flutter_cake_app/utils/base_env.dart';
import 'package:flutter_cake_app/utils/extensions.dart';
import 'package:flutter_cake_app/view/categories/categories_view.dart';
import 'package:flutter_cake_app/view/mainView/main_view.dart';
import 'package:flutter_cake_app/view/productDetail/product_detail_view.dart';
import 'package:flutter_cake_app/view/products/products_view.dart';

class AppAdsIds {
  static int adCount = 0;
  static int adCountLimit = 3;

  ///* test ad ids
  // static const adAppId = 'ca-app-pub-3940256099942544~3347511713';
  // static const adHomeBannerId = 'ca-app-pub-3940256099942544/9214589741';
  // static const adDetailBannerId = 'ca-app-pub-3940256099942544/9214589741';
  // static const adCategoriesBannerId = 'ca-app-pub-3940256099942544/9214589741';
  // static const adProductsBannerId = 'ca-app-pub-3940256099942544/9214589741';
  //
  // static const interstitialAdId = 'ca-app-pub-3940256099942544/1033173712';

  ///* real ads Id's

  static const adAppId = 'ca-app-pub-7455740448880424~1353054317';
  static const adHomeBannerId = 'ca-app-pub-7455740448880424/2550585916';
  static const adDetailBannerId = 'ca-app-pub-7455740448880424/4650135647';
  static const adCategoriesBannerId = 'ca-app-pub-7455740448880424/8429598554';
  static const adProductsBannerId = 'ca-app-pub-7455740448880424/5803435216';

  static const interstitialAdId = 'ca-app-pub-7455740448880424/7231270794';

  static void showInterstitialAd({
    required NavigationScreensEnum navigationEnum,
    required BuildContext context,
    String categoryName = '',
    ProductModel? productModel,
  }) {
    if (BaseEnv.instance.status.appFlavor() == AppFlavorEnum.free) {
      if (AppAdsIds.adCount == AppAdsIds.adCountLimit) {
        InterstitialAdSingleton().showInterstitialAd(
          adFailedToLoad: (adFailed) {
            InterstitialAdSingleton().loadInterstitialAd(adUnitId: 'adUnitId');
            AppAdsIds.adCount = 0;
            navigateToScreen(
              screen: navigationEnum,
              context: context,
              productModel: productModel,
              categoryName: categoryName,
            );
          },
          adLoaded: (adLoaded) {
            InterstitialAdSingleton().loadInterstitialAd(adUnitId: 'adUnitId');
            AppAdsIds.adCount = 0;
            navigateToScreen(
              screen: navigationEnum,
              context: context,
              productModel: productModel,
              categoryName: categoryName,
            );
          },
        );
      } else {
        AppAdsIds.adCount += 1;
        navigateToScreen(
          screen: navigationEnum,
          context: context,
          productModel: productModel,
          categoryName: categoryName,
        );
      }
    } else {
      navigateToScreen(
        screen: navigationEnum,
        context: context,
        productModel: productModel,
        categoryName: categoryName,
      );
    }
  }

  static void navigateToScreen({
    required NavigationScreensEnum screen,
    required BuildContext context,
    String categoryName = '',
    ProductModel? productModel,
  }) {
    switch (screen) {
      case NavigationScreensEnum.seeAllCategories:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              CategoriesView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        ));
        break;
      case NavigationScreensEnum.categoriesItem:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ProductsView(categoryName: categoryName),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        ));
        break;
      case NavigationScreensEnum.productsItem:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ProductDetailView(
            productModel: productModel ?? ProductModel.initial(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        ));
        break;

      case NavigationScreensEnum.onPop:
        Navigator.of(context).pop();
        break;

      case NavigationScreensEnum.none:
        break;

      default:
        Navigator.of(context).pop();
        break;
    }
  }
}
