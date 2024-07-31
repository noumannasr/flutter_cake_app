import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/adService/ad_service.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/model/cake_model.dart';
import 'package:flutter_cake_app/view/mainView/components/category_item.dart';
import 'package:flutter_cake_app/view/mainView/components/popular_item.dart';
import 'package:flutter_cake_app/view/mainView/main_vm.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Sweet Cake's",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
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
              SizedBox(
                height: deviceHeight * 0.75,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      // color: Colors.white
                    ),
                    child: Consumer<MainVm>(
                      builder: (context, mainVm, child) {
                        return mainVm.isLoading
                            ? SizedBox(
                                height: deviceHeight * 0.5,
                                width: deviceWidth,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : mainVm.isLoading == false && mainVm.cakes.isEmpty
                                ? SizedBox(
                                    height: deviceHeight * 0.5,
                                    width: deviceWidth,
                                    child: const Center(
                                        child: Text(
                                      'No Recipes Found',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    )),
                                  )
                                : SizedBox(
                                    //height: deviceHeight * 0.28,
                                    child: FadeInUp(
                                      delay: const Duration(milliseconds: 200),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 0,
                                            bottom: 0),
                                        child: GridView.builder(
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                2, // Number of columns
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                            childAspectRatio:
                                                1.0, // Adjust aspect ratio for item size
                                          ),
                                          itemCount: mainVm.cakes.length,
                                          itemBuilder: (context, index) {
                                            final item = mainVm.cakes[index];
                                            return CategoryItem(
                                                cakeModel: item);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.08,
                child: FutureBuilder<void>(
                  future: adService.loadAdHome(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error loading ad: ${snapshot.error}');
                    } else {
                      return AdWidget(ad: adService.adHome);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
