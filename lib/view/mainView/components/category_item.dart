import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_images.dart';
import 'package:flutter_cake_app/model/category_model.dart';
import 'package:lottie/lottie.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  final Function() onTap;
  const CategoryItem({super.key, required this.categoryModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: size.height*0.13,
          width: size.width*0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
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
                        AppImages.lottieImageLoading), // Replace with your Lottie animation
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
