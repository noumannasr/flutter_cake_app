import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/model/cake_model.dart';

class CategoryItem extends StatelessWidget {
  final CakeModel cakeModel;
  const CategoryItem({super.key, required this.cakeModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4), //bg,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
                height: 55,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(0),
                child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: cakeModel.image,
                        fit: BoxFit.cover,
                      ),
                    )
                )
            ),
          ),
          const SizedBox(height: 8),
          Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  cakeModel.title,
                  style: const TextStyle(
                      color: Color(0xFF364B5F),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ))
        ],
      ),
    );
  }
}
