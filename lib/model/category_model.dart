class CategoryModel {

  final String categoryName;
  final String categoryImage;
  final bool isActive;

  CategoryModel({required this.categoryName, required this.categoryImage, required this.isActive});

  factory CategoryModel.fromMap(Map<String, dynamic> data) {
    return CategoryModel(
        categoryName: data['categoryName'],
        isActive: data['isActive'],
        categoryImage: data['categoryImage'],

      // ... other fields
    );
  }

}