import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grebo/core/constants/app_theme.dart';
import 'package:grebo/core/service/googleAdd/addHandler.dart';
import 'package:grebo/core/service/repo/editProfileRepo.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/ui/global.dart';
import 'package:grebo/ui/screens/baseScreen/baseScreen.dart';
import 'package:grebo/ui/screens/baseScreen/controller/baseController.dart';
import 'package:grebo/ui/screens/editBusinessprofile/details1.dart';
import 'package:grebo/ui/screens/onbording.dart';
import 'package:grebo/ui/screens/selectservice.dart';
import 'package:grebo/ui/shared/userController.dart';
import 'package:grebo/ui/shared/utils_notification.dart';

import 'core/utils/lang.dart';
import 'core/utils/sharedpreference.dart';
import 'core/viewmodel/controller/imagepickercontoller.dart';

late UserController userController;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //--Firebase initialize
  await Firebase.initializeApp();

  //--Google Add initialize
  GoogleAddHandler.initialize();
  globalVerbsInit();

  await GetStorage.init();
  await getUserDetail();
  // listen for background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // firebase messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // request for notification permission
  // only applicable for iOS, Mac, Web. For the Android the result is always authorized.
  // ignore: unused_local_variable
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // initialize the notifications
  if (!kIsWeb) {
    // ic_notification is a drawable source added in the Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    final FlutterLocalNotificationsPlugin plugin =
        FlutterLocalNotificationsPlugin();

    // initialise the plugin
    await plugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      // notification tapped
      if (payload != null) {
        Map<String, dynamic> data = jsonDecode(payload);
        await NotificationUtils().handleNotificationData(data);
      }
    });

    // create the channel
    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
            NotificationUtils().androidNotificationChannel);
  }
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  userController.globalCategory = await EditProfileRepo.getCategories();

  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final BaseController baseController = Get.put(BaseController());
  @override
  void initState() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await NotificationUtils().handleNotificationData(message.data);
    });
    // listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // received the message while the app was foreground
      // here the notification is not shown automatically.
      await NotificationUtils().handleNewNotification(message, false);
    });
    FirebaseMessaging.instance.getInitialMessage().then((value) async {
      if (value != null) {
        await NotificationUtils().handleNotificationData(value.data);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      builder: (context, child) => MediaQuery(
        child: child as Widget,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      ),
      initialBinding: BaseBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Grebo',
      home: navigationScreen
          ? userController.user.profileCompleted ||
                  userController.user.userType ==
                      getServiceTypeCode(ServicesType.userType)
              ? BaseScreen()
              : DetailsPage1()
          : onBoardingHideRead()
              ? ChooseServices()
              : OnBoarding(),
      translations: Lang(),
      theme: AppTheme.defTheme,
      locale: Locale('en', 'US'), //Localizations.localeOf(context),
      fallbackLocale: Locale('en', 'US'),
    );
  }
}

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceController(), fenix: true);
  }
}
