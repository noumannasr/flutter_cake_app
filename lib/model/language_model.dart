class LanguageModel {

  final String languageName;
  final bool isActive;

  LanguageModel({required this.languageName, required this.isActive});

  factory LanguageModel.fromMap(Map<String, dynamic> data) {
    return LanguageModel(
      languageName: data['languageName'],
      isActive: data['isActive'],
    );
  }

}