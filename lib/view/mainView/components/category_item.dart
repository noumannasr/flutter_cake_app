import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/model/cake_model.dart';
import 'package:flutter_cake_app/model/category_model.dart';
import 'package:flutter_cake_app/view/cakeDetail/cake_detail_view.dart';
import 'package:lottie/lottie.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryItem({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          FirebaseAnalytics.instance.setUserProperty(
              name: 'Cake Recipies', value: categoryModel.categoryName.toString());

          FirebaseAnalytics.instance.logEvent(
            name: '${categoryModel.categoryName.toString()}',
            parameters: {
              'sample_string': 'clicked',
              'sample_int': 1,
            },
          );

          // Navigator.of(context).push(PageRouteBuilder(
          //   pageBuilder: (context, animation, secondaryAnimation) =>
          //       CakeDetailView(
          //     cakeModel: cakeModel,
          //   ),
          //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //     return child;
          //   },
          // ));
        },
        child: Container(
          height: size.height*0.13,
          width: size.width*0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            // alignment: Alignment.bottomLeft,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  height: size.height*0.095,
                  width: size.width*0.3,
                  placeholder: (context, url) => Center(
                    child: Lottie.asset(
                        'assets/lottie/lottie.json'), // Replace with your Lottie animation
                  ),
                  // Replace with your loading image path
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageUrl: categoryModel.categoryImage,
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white.withOpacity(0.7), //bg,
                  ),
                  child: Center(
                      child: Text(
                        categoryModel.categoryName,

                    style: const TextStyle(
                        color: Color(0xFF364B5F),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
            ],
          ),
        ),

        // Container(
        //   decoration: BoxDecoration(
        //     color: Colors.white.withOpacity(0.4), //bg,
        //     borderRadius: BorderRadius.circular(15),
        //   ),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Center(
        //         child: Container(
        //             height: size.height*0.15,
        //             width: size.width,
        //             decoration: BoxDecoration(
        //               shape: BoxShape.circle,
        //             ),
        //             padding: const EdgeInsets.all(0),
        //             child: Center(
        //                 child: ClipRRect(
        //                   borderRadius: BorderRadius.circular(10),
        //                   child: CachedNetworkImage(
        //                     imageUrl: cakeModel.cakeImage,
        //                     fit: BoxFit.cover,
        //                   ),
        //                 )
        //             )
        //         ),
        //       ),
        //       const SizedBox(height: 8),
        //       Center(
        //           child: Padding(
        //             padding: const EdgeInsets.only(left: 10, right: 10),
        //             child: Text(
        //               cakeModel.cakeName,
        //               style: const TextStyle(
        //                   color: Color(0xFF364B5F),
        //                   fontSize: 16,
        //                   fontWeight: FontWeight.w600),
        //               textAlign: TextAlign.center,
        //             ),
        //           ))
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
