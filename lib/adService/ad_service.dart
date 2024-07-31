import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  late BannerAd adHome;
  late BannerAd adDetail;


  Future<void> loadAdHome() async {
    adHome = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/9214589741',
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
      adUnitId: 'ca-app-pub-3940256099942544/9214589741',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
        },
        onAdFailedToLoad: (ad, error) {
          // Handle ad loading failure
        },
        // Other ad listeners as needed
      ),
    );
    await adDetail.load();
  }

}