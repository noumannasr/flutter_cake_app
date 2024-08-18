import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/adService/ad_service.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/model/category_model.dart';
import 'package:flutter_cake_app/model/product_model.dart';
import 'package:flutter_cake_app/view/mainView/components/category_item.dart';
import 'package:flutter_cake_app/view/productDetail/product_detail_view.dart';
import 'package:flutter_cake_app/widgets/product_item.dart';

class ProductsView extends StatefulWidget {
  final String categoryName;
  const ProductsView({super.key, required this.categoryName});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  //final adService = AdService();

  @override
  void dispose() {
    // TODO: implement dispose
    //adService.adProductsView.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    //adService.loadAdProducts();
    FirebaseAnalytics.instance.logEvent(name: 'Products_View_screen');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.categoryName + " Recipes",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
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
          stream: FirebaseFirestore.instance
              .collection('Products')
              .where('category', isEqualTo: widget.categoryName.toString()).where('isActive', isEqualTo: true)
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
    );
  }
}
