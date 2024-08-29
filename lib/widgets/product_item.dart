import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_ads_ids.dart';
import 'package:flutter_cake_app/model/product_model.dart';
import 'package:flutter_cake_app/view/mainView/main_view.dart';

class ProductItem extends StatelessWidget {
  final ProductModel productModel;

  const ProductItem({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        FirebaseAnalytics.instance
            .logEvent(name: productModel.productName.toString());
        AppAdsIds.showInterstitialAd(
          navigationEnum: NavigationScreensEnum.productsItem,
          context: context,
          productModel: productModel,
        );
      },
      leading: Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: productModel.productImage,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        productModel.productName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        productModel.cockingTime,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
        size: 15,
      ),
    );
  }
}
