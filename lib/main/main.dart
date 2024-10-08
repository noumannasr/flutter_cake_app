import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cake_app/adService/interstitial_ad_singleton.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/core/app_localizations.dart';
import 'package:flutter_cake_app/core/services/my_shared_preferences.dart';
import 'package:flutter_cake_app/my_app/my_app.dart';
import 'package:flutter_cake_app/utils/app_config.dart';
import 'package:flutter_cake_app/utils/base_env.dart';
import 'package:flutter_cake_app/utils/extensions.dart';
import 'package:flutter_cake_app/utils/permission_handler.dart';
import 'package:flutter_cake_app/view/languages/languages_vm.dart';
import 'package:flutter_cake_app/view/mainView/main_vm.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      if (kDebugMode) {
        print('Message is: $message');
      }
    }
  });

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/notification_icon');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializeSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializeSettings);
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;

  FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
    showFlutterNotification(message!);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('A new onMessageOpenedApp event was published!');
    }
  });
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            //one that already exists in example app.
            icon: '@drawable/notification_icon',
            color: AppColors.primaryColor),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void initMain({required String envFileName}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppConfig().setPackageInfo();
  await dotenv.load(fileName: envFileName);
  BaseEnv.instance.setEnv();

  if (BaseEnv.instance.status.appFlavor() == AppFlavorEnum.free) {
    await MobileAds.instance.initialize();
    InterstitialAdSingleton().loadInterstitialAd(adUnitId: 'adUnitId');
  }
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
  if (kDebugMode) {
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
  } else {
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  ///* get FirebaseToken
  var firebaseToken = await FirebaseMessaging.instance.getToken();
  debugPrint('DeviceFirebaseToken: $firebaseToken');

  await PermissionHandler.requestNotificationPermission(
    notificationPermissionStatus: (status) async {
      switch (status) {
        case PermissionStatusEnum.granted:
          // Set the background messaging handler early on, as a named top-level function
          FirebaseMessaging.onBackgroundMessage(
              _firebaseMessagingBackgroundHandler);

          if (!kIsWeb) {
            await setupFlutterNotifications();
          }
          break;
        case PermissionStatusEnum.denied:
          debugPrint('Permission Denied');
          break;
      }
    },
  );
  await MySharedPreference.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguagesVm()),
        ChangeNotifierProvider(create: (_) => MainVm()),
      ],
      child: EasyLocalization(
        key: const ValueKey('easyLocalization'),
        supportedLocales: [
          AppLocalizations.engLocale,
          AppLocalizations.arabicLocale,
          AppLocalizations.urduLocale,
          AppLocalizations.turkeyLocale,
          AppLocalizations.hindiLocale,
          AppLocalizations.bengaliLocale,
        ],
        path: AppLocalizations.translationFilePath,
        fallbackLocale: AppLocalizations.engLocale,
        startLocale: AppLocalizations.engLocale,
        child: const MyApp(),
      ),
    ),
  );
}
