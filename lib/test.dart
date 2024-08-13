// import 'package:flutter/material.dart';
// import 'package:flutter_cake_app/model/product_model.dart';
//
// class TextFilkjhh extends StatelessWidget {
//   const TextFilkjhh({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<Map<String, List<ProductModel>>>(
//       stream: provider.categoriesAndProductsStream,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (snapshot.connectionState == ConnectionState.waiting)
//         {
//         return const CircularProgressIndicator();
//         } else if (snapshot.hasData) {
//         final
//         categoriesAndProducts = snapshot.data!;
//         return ListView.builder(
//         itemCount: categoriesAndProducts.length,
//         itemBuilder: (context, index) {
//         final categoryName = categoriesAndProducts.keys.elementAt(index);
//         final products = categoriesAndProducts[categoryName]!;
//         return ExpansionTile(
//         title: Text(categoryName),
//         children: products.map((product) => ListTile(title: Text(''))).toList(),
//         );
//         },
//         );
//         } else {
//         return const Text('No data found');
//         }
//       },
//     );;
//   }
// }
