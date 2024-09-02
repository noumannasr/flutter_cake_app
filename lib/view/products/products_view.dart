import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/adService/ad_service.dart';
import 'package:flutter_cake_app/constants/app_ads_ids.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/constants/app_texts.dart';
import 'package:flutter_cake_app/constants/logs_events_keys.dart';
import 'package:flutter_cake_app/model/product_model.dart';
import 'package:flutter_cake_app/utils/base_env.dart';
import 'package:flutter_cake_app/utils/extensions.dart';
import 'package:flutter_cake_app/utils/utils.dart';
import 'package:flutter_cake_app/view/mainView/main_view.dart';
import 'package:flutter_cake_app/widgets/custom_app_bar.dart';
import 'package:flutter_cake_app/widgets/product_item.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ProductsView extends StatefulWidget {
  final String categoryName;

  const ProductsView({super.key, required this.categoryName});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final adService = AdService();

  @override
  void dispose() {
    if (BaseEnv.instance.status.appFlavor() == AppFlavorEnum.free) {
      adService.adProductsView.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    Utils.firebaseAnalyticsLogEvent(recipesScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return PopScope(
      canPop: true,
      onPopInvoked: (onPop) {
        AppAdsIds.showInterstitialAd(
          navigationEnum: NavigationScreensEnum.none,
          context: context,
        );
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.categoryName + " recipes".tr(),
          isShowBackText: true,
          onGoBack: () {
            AppAdsIds.showInterstitialAd(
              navigationEnum: NavigationScreensEnum.onPop,
              context: context,
            );
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      AppColors.secondaryColor,
                      AppColors.primaryColor,
                    ],
                  ),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(BaseEnv.instance.products)
                      .where('category',
                          isEqualTo: widget.categoryName.toString())
                      .where('isActive', isEqualTo: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final products = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final productData =
                            products[index].data() as Map<String, dynamic>;
                        final productModel = ProductModel(
                            categoryName: productData['category'],
                            productName: productData['productName'],
                            productImage: productData['productImage'],
                            cockingTime: productData['cockingTime'],
                            direction: productData['direction'],
                            ingredients: productData['ingredients'],
                            isActive: productData['isActive']);
                        return ProductItem(productModel: productModel);
                      },
                    );
                  },
                ),
              ),
            ),
            BaseEnv.instance.status.appFlavor() == AppFlavorEnum.free
                ? SizedBox(
                    height: height * 0.08,
                    child: FutureBuilder<void>(
                      future: adService.loadAdProducts(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error loading ad: ${snapshot.error}');
                        } else {
                          return AdWidget(ad: adService.adProductsView);
                        }
                      },
                    ),
                  )
                : IgnorePointer(),
          ],
        ),
      ),
    );
  }
}
