import 'package:flutter_cake_app/constants/app_ads_ids.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  late BannerAd adHome;
  late BannerAd adCategoriesView;
  late BannerAd adProductsView;
  late BannerAd adDetail;

  Future<void> loadAdHome() async {
    adHome = BannerAd(
      adUnitId: AppAdsIds.adHomeBannerId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print(ad.toString() + ' Add Loaded');
        },
        onAdFailedToLoad: (ad, error) {
          // Handle ad loading failure
          print(error.toString() + ' Add Loaded Error');
        },
        // Other ad listeners as needed
      ),
    );
    await adHome.load();
  }

  Future<void> loadAdDetail() async {
    adDetail = BannerAd(
      adUnitId: AppAdsIds.adDetailBannerId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, error) {
          // Handle ad loading failure
        },
        // Other ad listeners as needed
      ),
    );
    await adDetail.load();
  }

  Future<void> loadAdCategories() async {
    adCategoriesView = BannerAd(
      adUnitId: AppAdsIds.adCategoriesBannerId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, error) {
          // Handle ad loading failure
        },
        // Other ad listeners as needed
      ),
    );
    await adCategoriesView.load();
  }

  Future<void> loadAdProducts() async {
    adProductsView = BannerAd(
      adUnitId: AppAdsIds.adProductsBannerId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, error) {
          // Handle ad loading failure
        },
        // Other ad listeners as needed
      ),
    );
    await adProductsView.load();
  }
}
