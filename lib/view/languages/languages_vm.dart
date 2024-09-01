import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/core/services/my_shared_preferences.dart';
import 'package:flutter_cake_app/model/language_model.dart';
import 'package:flutter_cake_app/view/mainView/main_view.dart';
import 'package:flutter_cake_app/view/mainView/main_vm.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class LanguagesVm extends ChangeNotifier {
  LanguageModel languageModel =
      LanguageModel(languageName: '', isActive: false);
  String _selectedLanguage = "English";
  String _selectedHomeLanguage = "English";
  final List<LanguageModel> _languageList = [];

  int i = 0;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<LanguageModel> get languageList => _languageList;
  String get selectedLanguage => _selectedLanguage;


  LanguagesVm() {
    getSelectedLang();
    getLanguages();
  }


  setSelectedLang(String lang, BuildContext context) {
    _selectedLanguage = lang;
    notifyListeners();
    MySharedPreference.setSelectedLang(lang);

  }

  save(BuildContext context) {
    MySharedPreference.setIsFirstLogin(false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainView()),
    ).then((va) {

      //setSelectedLangHome(lang, context);
    });
  }


  getSelectedLang() {
    _selectedLanguage = MySharedPreference.getLang();
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
