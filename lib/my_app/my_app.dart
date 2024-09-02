import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/utils/base_env.dart';
import 'package:flutter_cake_app/utils/extensions.dart';
import 'package:flutter_cake_app/view/splash/splash_view.dart';
import 'package:flutter_cake_app/widgets/no_internect_connectivity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage(BaseEnv.instance.status.appFlavorIcon()), context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return NoInternetAppWidget(
          child: MaterialApp(
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
            ],
            debugShowCheckedModeBanner: false,
            title: BaseEnv.instance.status.appFlavorName(),
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              textTheme: GoogleFonts.montserratTextTheme(textTheme),
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}