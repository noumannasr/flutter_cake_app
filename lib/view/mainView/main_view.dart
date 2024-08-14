import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/adService/ad_service.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/model/cake_model.dart';
import 'package:flutter_cake_app/view/cakeDetail/cake_detail_view.dart';
import 'package:flutter_cake_app/view/mainView/components/category_item.dart';
import 'package:flutter_cake_app/view/mainView/components/popular_item.dart';
import 'package:flutter_cake_app/view/mainView/main_vm.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final adService = AdService();

  @override
  void dispose() {
    // TODO: implement dispose
    adService.adHome.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    adService.loadAdHome();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    FirebaseAnalytics.instance.setCurrentScreen(screenName: "Main Screen");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Delicious & Tasty Recipes",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<MainVm>(
        builder: (context, mainVm, child) {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      //borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        AppColors.secondaryColor,
                        AppColors.lightSecondaryColor,
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,bottom: 8, right: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Categories', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                            Text('See all', style: TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 2,right: 2),
                        child: SizedBox(
                          height: deviceHeight * 0.13,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: mainVm.categories.length,
                              itemBuilder: (context, index) {
                                return CategoryItem(
                                    categoryModel: mainVm.categories[index]);
                              }),
                        ),
                      ),

                      SizedBox(
                        height: deviceHeight * 0.7,
                        child: mainVm.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ScrollableListTabScroller.defaultComponents(
                                padding: EdgeInsets.zero,
                                headerContainerProps:
                                    HeaderContainerProps(height: 60),
                                tabBarProps: TabBarProps(
                                    dividerColor: Colors.red.withOpacity(0.0)),
                                itemCount: mainVm.finalData.length,
                                earlyChangePositionOffset: 30,
                                tabBuilder: (BuildContext context, int index,
                                        bool active) =>
                                    Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            colors: active
                                                ? [
                                                    AppColors
                                                        .lightSecondaryColor1,
                                                    AppColors
                                                        .lightSecondaryColor2
                                                  ]
                                                : [
                                                    AppColors.lightGreyColor,
                                                    AppColors
                                                        .lightSecondaryColor
                                                  ])),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        mainVm.finalData.keys.elementAt(index),
                                        style: !active
                                            ? null
                                            : TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: active
                                                    ? AppColors.primaryColor
                                                    : Colors.green),
                                      ),
                                    ),
                                  ),
                                ),
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mainVm.finalData.keys.elementAt(index),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17),
                                      ),
                                      ...mainVm.finalData.values
                                          .elementAt(index)
                                          .asMap()
                                          .map(
                                            (index, productModel) => MapEntry(
                                              index,
                                              ListTile(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        CakeDetailView(
                                                      productModel:
                                                          productModel,
                                                    ),
                                                    transitionsBuilder:
                                                        (context,
                                                            animation,
                                                            secondaryAnimation,
                                                            child) {
                                                      return child;
                                                    },
                                                  ));
                                                },
                                                leading: Container(
                                                  height: 60,
                                                  width: 60,
                                                  // decoration: BoxDecoration(
                                                  //     shape: BoxShape.circle,
                                                  //     color: Colors.grey),
                                                  alignment: Alignment.center,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl: productModel
                                                          .productImage,
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                title: Text(
                                                    productModel.productName),
                                                subtitle: Text(
                                                    productModel.cockingTime),
                                                trailing: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          )
                                          .values
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      // SizedBox(
                      //   height: deviceHeight * 0.08,
                      //   child: FutureBuilder<void>(
                      //     future: adService.loadAdHome(),
                      //     builder: (BuildContext context,
                      //         AsyncSnapshot<void> snapshot) {
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.waiting) {
                      //         return const Center(
                      //             child: CircularProgressIndicator());
                      //       } else if (snapshot.hasError) {
                      //         return Text(
                      //             'Error loading ad: ${snapshot.error}');
                      //       } else {
                      //         return AdWidget(ad: adService.adHome);
                      //       }
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
