import 'package:flutter/material.dart';
import 'package:flutter_cake_app/adService/ad_service.dart';
import 'package:flutter_cake_app/constants/app_ads_ids.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/constants/logs_events_keys.dart';
import 'package:flutter_cake_app/model/product_model.dart';
import 'package:flutter_cake_app/utils/base_env.dart';
import 'package:flutter_cake_app/utils/extensions.dart';
import 'package:flutter_cake_app/utils/utils.dart';
import 'package:flutter_cake_app/view/mainView/main_view.dart';
import 'package:flutter_cake_app/view/productDetail/widgets/product_detail_bannerAd_widget.dart';
import 'package:flutter_cake_app/view/productDetail/widgets/product_detail_paid_widget.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDetailView extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailView({super.key, required this.productModel});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final adService = AdService();

  @override
  void dispose() {
    if (BaseEnv.instance.status.appFlavor() == AppFlavorEnum.free) {
      adService.adDetail.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    Utils.firebaseAnalyticsLogEvent(recipesDetailScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondaryColor,
            AppColors.primaryColor,
          ],
        ),
      ),
      child: PopScope(
        canPop: true,
        onPopInvoked: (canPop) {
          AppAdsIds.showInterstitialAd(
            navigationEnum: NavigationScreensEnum.none,
            context: context,
          );
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BaseEnv.instance.status.appFlavor() == AppFlavorEnum.free
              ? ProductDetailBannerAdWidget(
                  productModel: widget.productModel,
                  adService: adService,
                )
              : ProductDetailPaidWidget(
                  productModel: widget.productModel,
                ),
          // body: Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       height: height * 0.9,
          //       decoration: const BoxDecoration(
          //         gradient: LinearGradient(
          //           begin: Alignment.topLeft,
          //           end: Alignment.bottomRight,
          //           colors: [
          //             AppColors.secondaryColor,
          //             AppColors.primaryColor,
          //           ],
          //         ),
          //       ),
          //       child: SingleChildScrollView(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Stack(
          //               alignment: Alignment.bottomCenter,
          //               children: [
          //                 SizedBox(
          //                     height: height * 0.4,
          //                     width: width,
          //                     child: CachedNetworkImage(
          //                       imageUrl:
          //                           widget.productModel.productImage.toString(),
          //                       fit: BoxFit.cover,
          //                     )),
          //                 SizedBox(
          //                   height: height * 0.4,
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       GestureDetector(
          //                         onTap: () {
          //                           AppAdsIds.showInterstitialAd(
          //                             navigationEnum:
          //                                 NavigationScreensEnum.onPop,
          //                             context: context,
          //                           );
          //                         },
          //                         child: Padding(
          //                           padding:
          //                               EdgeInsets.only(left: 14.w, top: 25.h),
          //                           child: Container(
          //                             height: 40.w,
          //                             width: 40.h,
          //                             alignment: Alignment.center,
          //                             decoration: BoxDecoration(
          //                                 color: AppColors.primaryColor
          //                                     .withOpacity(0.8),
          //                                 shape: BoxShape.circle),
          //                             child: SvgPicture.asset(
          //                               SvgAssets.backIcon,
          //                               colorFilter: ColorFilter.mode(
          //                                   Colors.black, BlendMode.srcIn),
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       Container(
          //                         width: width,
          //                         height: height * 0.07,
          //                         decoration: BoxDecoration(
          //                           color: Colors.white.withOpacity(0.5),
          //                         ),
          //                         child: Padding(
          //                           padding: const EdgeInsets.only(
          //                             left: 12,
          //                             bottom: 5,
          //                             top: 10,
          //                           ),
          //                           child: Text(
          //                             widget.productModel.productName,
          //                             style: TextStyle(
          //                                 color: Colors.black,
          //                                 fontWeight: FontWeight.bold,
          //                                 fontSize: 23),
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             DetailItem(
          //               title: 'Ingredients',
          //               text: widget.productModel.ingredients,
          //             ),
          //             DetailItem(
          //               title: 'Direction',
          //               text: widget.productModel.direction,
          //             ),
          //             SizedBox(
          //               height: height * 0.02,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //
          //     BaseEnv.instance.status.appFlavor() == AppFlavorEnum.free
          //         ? SizedBox(
          //             height: height * 0.08,
          //             child: FutureBuilder<void>(
          //               future: adService.loadAdDetail(),
          //               builder: (BuildContext context,
          //                   AsyncSnapshot<void> snapshot) {
          //                 if (snapshot.connectionState ==
          //                     ConnectionState.waiting) {
          //                   return const Center(
          //                       child: CircularProgressIndicator());
          //                 } else if (snapshot.hasError) {
          //                   return Text('Error loading ad: ${snapshot.error}');
          //                 } else {
          //                   return AdWidget(ad: adService.adDetail);
          //                 }
          //               },
          //             ),
          //           )
          //         : IgnorePointer(),
          //   ],
          // ),
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String title;
  final String text;

  const DetailItem({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
            bottom: 5,
            top: 10,
          ),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Html(
                shrinkWrap: true,
                data: text,
                style: {
                  "body":
                      Style(margin: Margins.zero, padding: HtmlPaddings.zero),
                  "html": Style(
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: FontSize.medium,
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero),
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
