import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cake_app/adService/ad_service.dart';
import 'package:flutter_cake_app/constants/app_ads_ids.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/constants/app_texts.dart';
import 'package:flutter_cake_app/constants/logs_events_keys.dart';
import 'package:flutter_cake_app/model/product_model.dart';
import 'package:flutter_cake_app/utils/app_config.dart';
import 'package:flutter_cake_app/utils/utils.dart';
import 'package:flutter_cake_app/view/mainView/components/category_item.dart';
import 'package:flutter_cake_app/view/mainView/main_vm.dart';
import 'package:flutter_cake_app/widgets/app_drawer.dart';
import 'package:flutter_cake_app/widgets/material_button.dart';
import 'package:flutter_cake_app/widgets/product_item.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';
import 'package:searchable_listview/searchable_listview.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final adService = AdService();

  @override
  void dispose() {
    Provider.of<MainVm>(context).focusNode.dispose();
    adService.adHome.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Utils.firebaseAnalyticsLogEvent(dashboardScreen);
    versionCheck();
    super.initState();
  }

  Future<void> versionCheck() async {
    double currentVersion = double.parse(
        AppConfig().packageInfo.version.trim().replaceAll(".", ""));

    print("Current Version is:" + currentVersion.toString());

    //Get Latest version info from firebase config
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

    try {
      // Using zero duration to force fetching from remote server.
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 0),
        minimumFetchInterval: Duration.zero,
      ));

      await remoteConfig.fetchAndActivate();
      double newVersion = double.parse(
          remoteConfig.getString('app_version').trim().replaceAll(".", ""));
      print("Remote Config Version is:" + newVersion.toString());
      if (newVersion > currentVersion) {
        Utils.showVersionDialog(
          context: context,
          onTap: () {
            Utils.launchURL(Uri.parse(AppText.appLink));
          },
        );
      }
    } on PlatformException catch (exception) {
      // Fetch throttled.
      debugPrint(exception.message.toString());
    } catch (exception) {
      debugPrint(
          'Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final deviceWidth = MediaQuery.sizeOf(context).width;

    return Container(
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
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
          ),
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            AppText.appName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<MainVm>().refreshData();
            },
            child: Consumer<MainVm>(
              builder: (context, mainVm, child) {
                return SafeArea(
                  child: mainVm.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 0.5,
                          ),
                        )
                      : Center(
                          child: mainVm.categories.isEmpty &&
                                  mainVm.finalData.isEmpty
                              ? SizedBox(
                                  height: deviceHeight * 0.8,
                                  child: Center(child: Text('No data found')))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: deviceHeight * 0.08,
                                      child: FutureBuilder<void>(
                                        future: adService.loadAdHome(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<void> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error loading ad: ${snapshot.error}');
                                          } else {
                                            return AdWidget(
                                                ad: adService.adHome);
                                          }
                                        },
                                      ),
                                    ),
                                    mainVm.productsList.isEmpty
                                        ? SizedBox()
                                        : Center(
                                            child: SizedBox(
                                              height:
                                                  mainVm.filteredList.isEmpty
                                                      ? mainVm.searchController
                                                              .text.isNotEmpty
                                                          ? deviceHeight * 0.12
                                                          : deviceHeight * 0.09
                                                      : deviceHeight * 0.75,
                                              width: deviceWidth * 0.95,
                                              child:
                                                  SearchableList<ProductModel>(
                                                searchFieldEnabled: true,
                                                textInputType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                                textAlign: TextAlign.start,
                                                shrinkWrap: true,
                                                displayClearIcon: false,
                                                displaySearchIcon: false,
                                                focusNode: mainVm.focusNode,
                                                searchFieldWidth:
                                                    deviceWidth * 0.95,
                                                searchTextController:
                                                    mainVm.searchController,
                                                sortPredicate: (a, b) => a
                                                    .productName
                                                    .compareTo(b.productName),
                                                itemBuilder: (item) {
                                                  return mainVm.filteredList
                                                          .isNotEmpty
                                                      ? ProductItem(
                                                          productModel: item)
                                                      : SizedBox(
                                                          height: 0,
                                                        );
                                                },
                                                filter: (keyword) {
                                                  mainVm.updateFilteredList(
                                                      keyword);
                                                  return mainVm.filteredList;
                                                },
                                                emptyWidget: mainVm
                                                        .searchController
                                                        .text
                                                        .isNotEmpty
                                                    ? Center(
                                                        child: Container(
                                                          child: Text(
                                                            'No recipe found',
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height: 0,
                                                      ),
                                                initialList:
                                                    mainVm.filteredList,
                                                inputDecoration:
                                                    InputDecoration(
                                                  border: InputBorder.none,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  hintText: "Search Recipes",
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  contentPadding:
                                                      EdgeInsets.only(left: 10),
                                                ),
                                              ),
                                            ),
                                          ),
                                    SizedBox(
                                      height: mainVm.filteredList.isEmpty
                                          ? deviceHeight * 0.8
                                          : 0,
                                      child: Column(
                                        children: [
                                          mainVm.categories.isNotEmpty
                                              ? Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              bottom: 8,
                                                              right: 10,
                                                              top: 0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Categories',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              FirebaseAnalytics
                                                                  .instance
                                                                  .logEvent(
                                                                      name:
                                                                          'See_all_categories');

                                                              AppAdsIds
                                                                  .showInterstitialAd(
                                                                navigationEnum:
                                                                    NavigationScreensEnum
                                                                        .seeAllCategories,
                                                                context:
                                                                    context,
                                                              );
                                                            },
                                                            child: Text(
                                                              'See all',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              right: 2),
                                                      child: SizedBox(
                                                        height:
                                                            deviceHeight * 0.13,
                                                        width: deviceWidth,
                                                        child: RefreshIndicator(
                                                          onRefresh: mainVm
                                                              .refreshData,
                                                          color: Colors.blue,
                                                          child:
                                                              ListView.builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount: mainVm
                                                                .categories
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final item = mainVm
                                                                      .categories[
                                                                  index];
                                                              return CategoryItem(
                                                                categoryModel:
                                                                    mainVm.categories[
                                                                        index],
                                                                onTap: () {
                                                                  FirebaseAnalytics
                                                                      .instance
                                                                      .setUserProperty(
                                                                          name:
                                                                              'MainCategorySlider',
                                                                          value: item
                                                                              .categoryName
                                                                              .toString());

                                                                  FirebaseAnalytics
                                                                      .instance
                                                                      .logEvent(
                                                                    name:
                                                                        '${item.categoryName.toString()}',
                                                                    parameters: {
                                                                      'sample_string':
                                                                          'clicked',
                                                                      'sample_int':
                                                                          1,
                                                                    },
                                                                  );

                                                                  AppAdsIds
                                                                      .showInterstitialAd(
                                                                    navigationEnum:
                                                                        NavigationScreensEnum
                                                                            .categoriesItem,
                                                                    context:
                                                                        context,
                                                                    categoryName:
                                                                        item.categoryName,
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(
                                                  height: deviceHeight * 0.13,
                                                  child: Center(
                                                    child: Text(
                                                      'No categories found',
                                                    ),
                                                  ),
                                                ),
                                          mainVm.finalData.isNotEmpty &&
                                                  mainVm.productsList.isNotEmpty
                                              ? SizedBox(
                                                  height: deviceHeight * 0.59,
                                                  child: mainVm.isLoading
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator())
                                                      : ScrollableListTabScroller
                                                          .defaultComponents(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          headerContainerProps:
                                                              HeaderContainerProps(
                                                                  height: 60),
                                                          tabBarProps: TabBarProps(
                                                              dividerColor: Colors
                                                                  .red
                                                                  .withOpacity(
                                                                      0.0)),
                                                          itemCount: mainVm
                                                              .finalData.length,
                                                          earlyChangePositionOffset:
                                                              30,
                                                          tabBuilder: (BuildContext
                                                                      context,
                                                                  int index,
                                                                  bool
                                                                      active) =>
                                                              Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors:
                                                                      active
                                                                          ? [
                                                                              AppColors.lightSecondaryColor1,
                                                                              AppColors.lightSecondaryColor2
                                                                            ]
                                                                          : [
                                                                              AppColors.lightGreyColor,
                                                                              AppColors.lightSecondaryColor
                                                                            ],
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                child: Text(
                                                                  mainVm
                                                                      .finalData
                                                                      .keys
                                                                      .elementAt(
                                                                          index),
                                                                  style: !active
                                                                      ? null
                                                                      : TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: active
                                                                              ? AppColors.primaryColor
                                                                              : Colors.green),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          itemBuilder: (BuildContext
                                                                      context,
                                                                  int index) =>
                                                              Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  mainVm
                                                                      .finalData
                                                                      .keys
                                                                      .elementAt(
                                                                          index),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          17),
                                                                ),
                                                                ...mainVm
                                                                    .finalData
                                                                    .values
                                                                    .elementAt(
                                                                        index)
                                                                    .asMap()
                                                                    .map(
                                                                      (index, productModel) =>
                                                                          MapEntry(
                                                                        index,
                                                                        ProductItem(
                                                                            productModel:
                                                                                productModel),
                                                                      ),
                                                                    )
                                                                    .values
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                )
                                              : SizedBox(
                                                  height: deviceHeight * 0.59,
                                                  child: Center(
                                                    child: Text(
                                                      'No recipes found',
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

enum NavigationScreensEnum {
  seeAllCategories,
  categoriesItem,
  productsItem,
  onPop,
  none,
}
