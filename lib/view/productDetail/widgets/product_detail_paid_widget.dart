import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_ads_ids.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/model/product_model.dart';
import 'package:flutter_cake_app/svg_assets.dart';
import 'package:flutter_cake_app/view/mainView/main_view.dart';
import 'package:flutter_cake_app/view/productDetail/product_detail_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetailPaidWidget extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailPaidWidget({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: height,
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: height * 0.4,
                        width: width,
                        child: CachedNetworkImage(
                          imageUrl: productModel.productImage.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                AppAdsIds.showInterstitialAd(
                                  navigationEnum: NavigationScreensEnum.onPop,
                                  context: context,
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 14.w, top: 25.h),
                                child: Container(
                                  height: 40.w,
                                  width: 40.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.8),
                                      shape: BoxShape.circle),
                                  child: SvgPicture.asset(
                                    SvgAssets.backIcon,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: width,
                              height: height * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  bottom: 5,
                                  top: 10,
                                ),
                                child: Text(
                                  productModel.productName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  DetailItem(
                    title: 'ingredients'.tr(),
                    text: productModel.ingredients,
                  ),
                  DetailItem(
                    title: 'direction'.tr(),
                    text: productModel.direction,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
