import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/view/languages/languages_vm.dart';
import 'package:provider/provider.dart';

class SetLanguageView extends StatelessWidget {
  const SetLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Consumer<LanguagesVm>(
      builder: (context, languageVm, child) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            centerTitle: true,
            title: const Text(
              'Set Language',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: deviceHeight * 0.025,
                  ),
                  languageVm.isLoading ? CircularProgressIndicator(
                    strokeWidth: 1,
                    color: AppColors.primaryColor,
                  ) :
                  Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text('Choose Assets'),
                        items: languageVm.languageList
                            .map((item) => DropdownMenuItem<String>(
                          value: item.languageName,
                          child: Row(
                            children: [

                              Padding(
                                padding:
                                const EdgeInsets.only(
                                    left: 10),
                                child: Text(
                                  item.languageName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  overflow:
                                  TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ))
                            .toList(),
                        value: languageVm.selectedLanguage,
                        onChanged: (String? value) {
                          languageVm.setSelectedLang(value.toString(), context);
                        },
                        buttonStyleData: ButtonStyleData(
                          height: deviceHeight * 0.055,
                          width: deviceWidth * 0.92,
                          padding: const EdgeInsets.only(
                              left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [Colors.white, Colors.white],
                            ),
                          ),
                          elevation: 0,
                        ),
                        iconStyleData: IconStyleData(
                          // openMenuIcon: Icon(Icons.add),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                          ),
                          iconSize: 24,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          elevation: 0,
                          maxHeight: deviceHeight,
                          direction: DropdownDirection.right,
                          width: deviceWidth * 0.9,
                          padding: const EdgeInsets.only(
                              left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                16),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [Colors.white, Colors.white30],
                            ),
                          ),
                          // offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: Radius.circular(
                                16),
                            thickness:
                            MaterialStateProperty.all<double>(
                                6),
                            thumbVisibility:
                            MaterialStateProperty.all<bool>(
                                true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          // height: 40,
                          padding:
                          EdgeInsets.only(left: 1, right: 14),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: deviceHeight * 0.025,
                  ),
                  GestureDetector(
                    onTap: () {
                      languageVm.save( context);
                    },
                    child: Container(
                      width: deviceWidth * 0.92,
                      height: deviceHeight*0.05,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Center(child: Text("Save", style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
