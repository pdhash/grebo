import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:notification_permissions/notification_permissions.dart';

import 'core/utils/lang.dart';
import 'core/utils/sharedpreference.dart';
import 'core/viewmodel/controller/imagepickercontoller.dart';

late UserController userController;

void main() async {
  globalVerbsInit();
  WidgetsFlutterBinding.ensureInitialized();
  //--Firebase initialize
  await Firebase.initializeApp();
  //--Google Add initialize
  GoogleAddHandler.initialize();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  await GetStorage.init();
  userController = Get.put(UserController());
  await getUserDetail();
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
  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";
  final BaseController baseController = Get.put(BaseController());
  @override
  void initState() {
    super.initState();
    Future<String> getCheckNotificationPermStatus() {
      return NotificationPermissions.getNotificationPermissionStatus()
          .then((status) {
        switch (status) {
          case PermissionStatus.denied:
            return permDenied;
          case PermissionStatus.granted:
            return permGranted;
          case PermissionStatus.unknown:
            return permUnknown;
          case PermissionStatus.provisional:
            return permProvisional;
          default:
            return "";
        }
      });
    }

    getCheckNotificationPermStatus().then((value) {
      if (value == permGranted) {
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          print("A new onMessageOpenedApp event was published!");
          print(message.data);

          if (message.data["id"] == 3) {
            print("BaseScreen Controller 3");
            baseController.currentTab = 3;
            //lots added
          } else if (message.data["id"] == 4) {
            baseController.currentTab = 4;
            // lot status update
          }
        });
      }
    });
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
