import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/core/app_localizations.dart';
import 'package:flutter_cake_app/core/services/my_shared_preferences.dart';
import 'package:flutter_cake_app/main/main.dart';
import 'package:flutter_cake_app/model/language_model.dart';

class LanguagesVm extends ChangeNotifier {
  LanguageModel languageModel =
      LanguageModel(languageName: '', isActive: false);
  String _selectedLanguage = "English";
  final List<LanguageModel> _languageList = [];

  int i = 0;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<LanguageModel> get languageList => _languageList;

  String get selectedLanguage => _selectedLanguage;

  LanguagesVm() {
    getSelectedLang();
  }

  setSelectedLang(String lang, BuildContext context) async {
    _selectedLanguage = lang;
    notifyListeners();

    Future.delayed(Duration.zero, () {
      switch (lang) {
        case 'English':
          try {
            context.setLocale(AppLocalizations.engLocale);
          } on Exception catch (e) {
            debugPrint('Exception: ${e.toString()}');
          }
        case 'Arabic':
          try {
            context.setLocale(AppLocalizations.arabicLocale);
          } on Exception catch (e) {
            debugPrint('Exception: ${e.toString()}');
          }
        default:
          try {
            context.setLocale(AppLocalizations.engLocale);
          } on Exception catch (e) {
            debugPrint('Exception: ${e.toString()}');
          }
      }
    });
  }

  void save(BuildContext context, String selectedLanguage) async {
    await MySharedPreference.setSelectedLang(selectedLanguage);
    await MySharedPreference.setIsFirstLogin(false);
    Future.delayed(Duration.zero, () {
      // Remove any route in the stack
      Navigator.of(context).popUntil((route) => false);

      // Add the first route. Note MyApp() would be your first widget to the app.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    });
  }

  getSelectedLang() async {
    _selectedLanguage = await MySharedPreference.getLang();
    notifyListeners();
  }

  Future<List<LanguageModel>> getLanguages() async {
    _languageList.clear();
    setLoading(true);

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Languages')
          .where('isActive', isEqualTo: true)
          .get();

      for (var doc in querySnapshot.docs) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          final languageModel = LanguageModel.fromMap(data);
          _languageList.add(languageModel);
          print(_languageList.length.toString() + " This is the lang length");
          notifyListeners();
        } catch (e) {
          // Handle data conversion errors or invalid data
          print('Error parsing cake data in model: $e');
          setLoading(false);
          // Consider logging the error or handling it differently
        }
      }
      Future.delayed(const Duration(milliseconds: 100));
      notifyListeners();
      setLoading(false);
    } catch (e) {
      // Handle data conversion errors or invalid data
      print('Error parsing cake data 2: $e');
      setLoading(false);
      // Consider logging the error or handling it differently
    }

    return _languageList;
  }

  setLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }
}
