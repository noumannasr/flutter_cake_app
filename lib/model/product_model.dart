import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productName;
  final String categoryName;
  final String productImage;
  final String cockingTime;
  final String direction;
  final String ingredients;
  final bool isActive;

  ProductModel(
      {required this.categoryName,
      required this.productName,
      required this.productImage,
      required this.cockingTime,
      required this.direction,
      required this.ingredients,
      required this.isActive});

  factory ProductModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return ProductModel(
      productName: data['productName'],
      productImage: data['productImage'],
      categoryName: data['category'],
      cockingTime: data['cockingTime'],
      direction: data['direction'],
      ingredients: data['ingredients'],
      isActive: data['isActive'],
      // ... other properties
    );
  }

  factory ProductModel.initial() => ProductModel(
        categoryName: '',
        productName: '',
        productImage: '',
        cockingTime: '',
        direction: '',
        ingredients: '',
        isActive: false,
      );
}
