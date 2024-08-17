import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/adService/ad_service.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/model/cake_model.dart';
import 'package:flutter_cake_app/model/product_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
    // TODO: implement dispose
    adService.adDetail.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAnalytics.instance.logEvent(name: 'product_detail_view');
    adService.loadAdDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Container(
              height: height * 0.9,
              decoration: const BoxDecoration(
                  //borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color(0xFFffd7c8),
                    Color(0xFFfff9c6),

                    //Colors.amberAccent,
                  ])),
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
                            imageUrl:
                                widget.productModel.productImage.toString(),
                            fit: BoxFit.cover,
                          )),
                      SizedBox(
                        height: height * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 14, top: 25),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.8),
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.black,
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
                                  widget.productModel.productName,
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
                    title: 'Ingredients',
                    text: widget.productModel.ingredients,
                  ),
                  DetailItem(
                    title: 'Direction',
                    text: widget.productModel.direction,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.08,
            child: FutureBuilder<void>(
              future: adService.loadAdDetail(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error loading ad: ${snapshot.error}');
                } else {
                  return AdWidget(ad: adService.adDetail);
                }
              },
            ),
          ),
        ],
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
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
