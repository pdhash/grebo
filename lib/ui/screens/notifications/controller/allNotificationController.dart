import 'package:get/get.dart';
import 'package:grebo/core/service/repo/notificationRepo.dart';
import 'package:grebo/ui/screens/notifications/model/notificationModel.dart';

class NotificationController extends GetxController {
  int page = 1;

  Future<List<NotificationData>> fetchNotification(int offset) async {
    if (offset == 0) page = 1;
    if (page == -1) return [];
    List<NotificationData> getNotify = [];

    var request = await NotificationRepo.fetchNotification(page);
    getNotify = request!.data;

    page = request.hasMore ? page + 1 : -1;

    return getNotify;
  }

  Future readNotification(
      String notificationId, NotificationData notifyData) async {
    notifyData.seen = true;
    update();

    var request = await NotificationRepo.readNotification(notificationId);
    print(request);
  }
}
