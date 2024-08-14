import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
      FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
        {
        return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
        return
        Center(child: CircularProgressIndicator());
        }

        final categories = snapshot.data!.docs;


        return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust the number of columns as needed
        childAspectRatio:
        1.0, // Adjust the aspect ratio as needed
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
        final categoryData = categories[index].data() as Map<String, dynamic>;
        final categoryName = categoryData['name'];
        final categoryImage = categoryData['image']; // Assuming an 'image' field

        return Card(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.network(categoryImage), // Replace with your image loading logic
        Text(categoryName),
        ],
        ),
        );
        },
        );
      },
    ),
    );
  }
}
