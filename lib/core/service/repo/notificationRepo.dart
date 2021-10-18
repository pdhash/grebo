import 'dart:convert';

import 'package:grebo/ui/screens/notifications/model/notificationModel.dart';

import '../../../main.dart';
import '../apiHandler.dart';
import '../apiRoutes.dart';

class NotificationRepo {
  static Future<NotificationModel?> fetchNotification(int page) async {
    var response = await API.apiHandler(
        url: APIRoutes.notificationList,
        showLoader: false,
        header: {
          "Authorization": userController.userToken,
        },
        body: jsonEncode({"page": page}));
    if (response != null) {
      return NotificationModel.fromJson(response);
    } else
      return null;
  }
}
