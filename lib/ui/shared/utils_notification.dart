import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:grebo/core/service/repo/notificationRepo.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/utils/appFunctions.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/homeTab/controller/homeController.dart';
import 'package:grebo/ui/screens/homeTab/postdetails.dart';
import 'package:grebo/ui/screens/messagesTab/chatscreen.dart';

/// class to have functions related to notifications
class NotificationUtils {
  /// to create a single instance
  factory NotificationUtils() {
    _instance ??= NotificationUtils._();
    return _instance!;
  }

  NotificationUtils._();

  static NotificationUtils? _instance;

  // create a notification channel in Android
  AndroidNotificationChannel androidNotificationChannel =
      const AndroidNotificationChannel(
    'agenda_boa_notification_channel', // id
    'Agenda BOA notifications', // title
    'Channel to show the app notifications.', // description
    importance: Importance.max,
    playSound: true,
  );

  /// handle the new received notification.
  /// [fromBackground] = is this [message] is from background?
  Future<void> handleNewNotification(
      RemoteMessage message, bool fromBackground) async {
    // display the notification manually

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      // the push is from foreground
      // here we need to manually display the notification

      displayLocalNotification(
        id: message.hashCode,
        title: notification.title,
        body: notification.body,
        data: message.data,
      );

      return; // foreground push is handled
    }
  }

  bool notificationUnread = true;
  Future<void> handleAppLunchLocalNotification() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await FlutterLocalNotificationsPlugin()
            .getNotificationAppLaunchDetails();
    final didNotificationLaunchApp =
        notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
    if (didNotificationLaunchApp && notificationUnread) {
      if (notificationAppLaunchDetails!.payload != null) {
        notificationUnread = false;
        handleNotificationData(
            jsonDecode(notificationAppLaunchDetails.payload!));
      }
    }
  }

  /// handle the notification [data] when the user taps on the notification.
  Future<void> handleNotificationData(Map<String, dynamic> data) async {
    // maybe here we need to open specific screen or link

    int typeCode = int.parse(data["type"].toString());
    // if (data["reference"] != null && data["reference"] != "") {
    //   await NotificationRepo.readNotification(data["reference"]);
    // }
    if (typeCode == 2) {
      Map<String, dynamic> response = jsonDecode(data["payload"]);
      Get.to(() => ChatView(
          channelRef: response["channelRef"],
          businessRef: response["user"]["_id"],
          userName: userController.user.userType ==
                  getServiceTypeCode(ServicesType.userType)
              ? response["user"]["businessName"] ?? ""
              : response["user"]["name"] ?? ""));
    } else if (typeCode == 4) {
      // var response = jsonDecode(data["user"]);

      if (userController.user.userType ==
          getServiceTypeCode(ServicesType.userType)) {
        Get.find<HomeController>().currentPostRef = data["sourceRef"];

        Get.to(() => PostDetails(
              postRef: data["sourceRef"],
            ));
      }
    }
  }

  /// display a local notification
  void displayLocalNotification({
    required int id,
    required String? title,
    required String? body,
    String? imageUrl = "",
    Map<String, dynamic> data = const {},
  }) async {
    if (kIsWeb) {
      // TODO display the notification as toast in web
    } else {
      // display the local notification with flutter_local_notifications
      // currently this package doesn't work with web.

      FlutterLocalNotificationsPlugin().show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidNotificationChannel.id,
            androidNotificationChannel.name,
            androidNotificationChannel.description,
            color: const Color(0xFF242157),
            ticker: title,
            importance: Importance.high,
            // priority is required for heads up in android <= 7.1
            priority: Priority.high,
          ),
        ),
        payload: data.isNotEmpty ? jsonEncode(data) : null,
      );
    }
  }
}
