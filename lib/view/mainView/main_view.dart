import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/view/mainView/components/category_item.dart';
import 'package:flutter_cake_app/view/mainView/components/popular_item.dart';
import 'package:flutter_cake_app/view/mainView/main_vm.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
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
                AppColors.primaryColor,
                AppColors.secondaryColor,
                AppColors.lightSecondaryColor,
              ])),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        // color: Colors.white
                      ),
                      child: Column(
                        children: [
                          // SizedBox(
                          //   height: size.height * 0.2,
                          // ),
                          SizedBox(
                            //height: deviceHeight * 0.28,
                            child: FadeInUp(
                              delay: const Duration(milliseconds: 200),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0, bottom: 0),
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent:
                                        120.0, // Set the maximum width for each item
                                    mainAxisSpacing: 8.0,
                                    // Spacing between items on the main axis
                                    crossAxisSpacing:
                                        8.0, // Spacing between items on the cross axis
                                  ),
                                  itemCount: MainVm.cakes.length,
                                  itemBuilder: (context, index) {
                                    final item = MainVm.cakes[index];
                                    return CategoryItem(cakeModel: item);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Expanded(
                      child: Container(
                        // color: Color(0xffF2F2F2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 12,
                                bottom: 5,
                                top: 10,
                              ),
                              child: Text(
                                "Popular Cakes",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              height: deviceHeight * 0.5,
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: MainVm.cakes.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final item = MainVm.cakes[index];
                                    return PopularItem(cakeModel: item);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
