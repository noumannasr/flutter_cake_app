import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_ads_ids.dart';
import 'package:flutter_cake_app/constants/logs_events_keys.dart';
import 'package:flutter_cake_app/utils/utils.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdSingleton {
  static InterstitialAd? _interstitialAd;

  factory InterstitialAdSingleton() => _instance;

  InterstitialAdSingleton._();

  static final InterstitialAdSingleton _instance = InterstitialAdSingleton._();

  Future<void> loadInterstitialAd({required String adUnitId}) async {
    InterstitialAd.load(
      adUnitId: AppAdsIds.interstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          Utils.firebaseAnalyticsLogEvent(interstitialOnAdLoaded);
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          Utils.firebaseAnalyticsLogEvent(interstitialOnAdFailedToLoad);
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void showInterstitialAd({
    required Function(AdError adError) adFailedToLoad,
    required Function(String loaded) adLoaded,
  }) {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdFailedToShowFullScreenContent: (ad, error) {
          Utils.firebaseAnalyticsLogEvent(
              interstitialOnAdFailedToShowFullScreenContent);
          adFailedToLoad(error);
        },
        onAdImpression: (ad) {
          Utils.firebaseAnalyticsLogEvent(interstitialOnAdImpression);
        },
        onAdShowedFullScreenContent: (ad) {
          Utils.firebaseAnalyticsLogEvent(
              interstitialOnAdShowedFullScreenContent);
          adLoaded('Ad-Loaded');
        },
        onAdDismissedFullScreenContent: (ad) {
          Utils.firebaseAnalyticsLogEvent(
              interstitialOnAdDismissedFullScreenContent);
        },
        onAdClicked: (ad) {
          Utils.firebaseAnalyticsLogEvent(interstitialOnAdClicked);
        },
      );
      _interstitialAd!.show();
    } else {
      Utils.firebaseAnalyticsLogEvent(
          interstitialOnAdFailedToShowFullScreenContent);
      adFailedToLoad(
        AdError(
          0,
          'domain',
          'AdFailedTo-Loaded',
        ),
      );
    }
  }
}
