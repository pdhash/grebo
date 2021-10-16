import 'package:grebo/ui/screens/notifications/model/notificationModel.dart';

import '../../../main.dart';
import '../apiHandler.dart';
import '../apiRoutes.dart';

class NotificationRepo {
  static Future<NotificationModel?> fetchNotification() async {
    var response = await API.apiHandler(
        url: APIRoutes.notificationList,
        showLoader: false,
        header: {"Authorization": userController.userToken});
    if (response != null) {
      print(response);
      print(NotificationModel.fromJson(response).data[0].text);
      return NotificationModel.fromJson(response);
    } else
      return null;
  }
}
