import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/adService/ad_service.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/model/category_model.dart';
import 'package:flutter_cake_app/view/mainView/components/category_item.dart';
import 'package:flutter_cake_app/view/mainView/main_vm.dart';
import 'package:flutter_cake_app/view/products/products_view.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final adService = AdService();

  @override
  void dispose() {
    // TODO: implement dispose
    adService.adCategoriesView.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    adService.loadAdCategories();
    FirebaseAnalytics.instance.logEvent(name: 'Categories_View_screen');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Categories',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              //borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                AppColors.secondaryColor,
                AppColors.primaryColor,
              ])),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            //borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
              AppColors.secondaryColor,
              AppColors.primaryColor,
            ])),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('Categories').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final categories = snapshot.data!.docs;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Adjust the number of columns as needed
                  childAspectRatio: 0.99,
                  mainAxisExtent: deviceHeight * 0.135
                  // Adjust the aspect ratio as needed
                  ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final categoryData =
                    categories[index].data() as Map<String, dynamic>;
                final categoryModel = CategoryModel(
                    categoryName: categoryData['categoryName'],
                    categoryImage: categoryData['categoryImage'],
                    isActive: categoryData['isActive']);
                final categoryImage =
                    categoryData['categoryImage']; // Assuming an 'image' field

                return CategoryItem(
                    categoryModel: categoryModel,
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ProductsView(
                                categoryName: categoryModel.categoryName),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return child;
                        },
                      ));
                    });
              },
            );
          },
        ),
      ),
    );
  }
}
