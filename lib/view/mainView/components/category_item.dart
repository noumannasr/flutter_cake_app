import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/model/cake_model.dart';
import 'package:flutter_cake_app/view/cakeDetail/cake_detail_view.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/constant.dart';

class CategoryItem extends StatelessWidget {
  final CakeModel cakeModel;
  const CategoryItem({super.key, required this.cakeModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(PageRouteBuilder(
          pageBuilder: (context,
              animation,
              secondaryAnimation) =>
              CakeDetailView(
                cakeModel: cakeModel,
              ),
          transitionsBuilder: (context,
              animation,
              secondaryAnimation,
              child) {
            return child;
          },
        ));
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              placeholder: (context, url) => Center(
                  child:
                  Lottie.asset('assets/lottie/lottie.json'), // Replace with your Lottie animation
            ),
                // Replace with your loading image path
                errorWidget: (context, url, error) => Icon(Icons.error),
              imageUrl: cakeModel.cakeImage,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            height: size.height*0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white.withOpacity(0.7), //bg,
            ),
            child: Center(
                child: Text(
                  cakeModel.cakeName,
                  style: const TextStyle(
                      color: Color(0xFF364B5F),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                )),
          ),
        ],
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
    );
  }
}
