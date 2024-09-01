
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/view/splash/splash_vm.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (BuildContext context) => SplashVm(context),
      child: Consumer<SplashVm>(
        builder: (context, vm, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            //backgroundColor: AppColors.whiteColor,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // colors: [Colors.blue, Colors.purple],
                  colors: [AppColors.primaryColor, AppColors.secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeInDown(
                      delay: const Duration(milliseconds: 400),
                      child: Container(
                        height: 100,
                        width: 100,

                        child: Center(
                          child: Image.asset(
                            "assets/icon/free_flavor_app_icon.png",
                           // color: Colors.white,
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
