class CakeModel {
  final String cakeName;
  final String cakeImage;
  final String cakeBakingTime;
  final String cakeIngredients;
  final String cakeDirection;

  CakeModel(
      {required this.cakeName,
      required this.cakeImage,
      required this.cakeBakingTime,
      required this.cakeIngredients,
      required this.cakeDirection});

  factory CakeModel.fromMap(Map<String, dynamic> data) {
    return CakeModel(
        cakeName: data['cakeName'],
        cakeImage: data['cakeImage'],
        cakeBakingTime: data['cakeBakingTime'],
        cakeIngredients: data['cakeIngredients'],
        cakeDirection: data['cakeDirection']
        // ... other fields
        );
  }
}
