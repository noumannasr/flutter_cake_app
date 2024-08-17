import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/view/mainView/main_view.dart';
import 'package:flutter_cake_app/view/mainView/main_vm.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  if (Firebase.apps.isEmpty) {
    if (Platform.isIOS) {
    } else {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
        apiKey: 'AIzaSyBdBR2TO5DEWLeh_jLfzhIGXkBUPNWIsSs',
        appId: '1:791953399451:android:f12c404b04e0df2348f03e',
        messagingSenderId: '791953399451',
        projectId: "flutter-cake-recipe-app",
        storageBucket: "flutter-cake-recipe-app.appspot.com",
      ));
    }
  }
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainVm(context)),
      ],
      child: MaterialApp(
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.montserratTextTheme(textTheme),
        ),
        home: const MainView(),
      ),
    );
  }
}
