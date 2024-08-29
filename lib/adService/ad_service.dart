import 'package:flutter_cake_app/constants/app_ads_ids.dart';
import 'package:flutter_cake_app/constants/logs_events_keys.dart';
import 'package:flutter_cake_app/utils/utils.dart';
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
          Utils.firebaseAnalyticsLogEvent(homeBannerOnLoaded);
        },
        onAdFailedToLoad: (ad, error) {
          Utils.firebaseAnalyticsLogEvent(homeBannerOnFailedToLoad);
        },
        onAdImpression: (ad) {
          Utils.firebaseAnalyticsLogEvent(homeBannerOnAdImpression);
        },
        onAdClicked: (ad) {
          Utils.firebaseAnalyticsLogEvent(homeBannerOnAdClicked);
        },
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
        onAdLoaded: (ad) {
          Utils.firebaseAnalyticsLogEvent(detailBannerOnLoaded);
        },
        onAdFailedToLoad: (ad, error) {
          Utils.firebaseAnalyticsLogEvent(detailBannerOnFailedToLoad);
        },
        onAdImpression: (ad) {
          Utils.firebaseAnalyticsLogEvent(detailBannerOnAdImpression);
        },
        onAdClicked: (ad) {
          Utils.firebaseAnalyticsLogEvent(detailBannerOnAdClicked);
        },
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
        onAdLoaded: (ad) {
          Utils.firebaseAnalyticsLogEvent(categoriesBannerOnLoaded);
        },
        onAdFailedToLoad: (ad, error) {
          Utils.firebaseAnalyticsLogEvent(categoriesBannerOnFailedToLoad);
        },
        onAdImpression: (ad) {
          Utils.firebaseAnalyticsLogEvent(categoriesBannerOnAdImpression);
        },
        onAdClicked: (ad) {
          Utils.firebaseAnalyticsLogEvent(categoriesBannerOnAdClicked);
        },
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
        onAdLoaded: (ad) {
          Utils.firebaseAnalyticsLogEvent(productsBannerOnLoaded);
        },
        onAdFailedToLoad: (ad, error) {
          Utils.firebaseAnalyticsLogEvent(productsBannerOnFailedToLoad);
        },
        onAdImpression: (ad) {
          Utils.firebaseAnalyticsLogEvent(productsBannerOnAdImpression);
        },
        onAdClicked: (ad) {
          Utils.firebaseAnalyticsLogEvent(productsBannerOnAdClicked);
        },
      ),
    );
    await adProductsView.load();
  }
}
