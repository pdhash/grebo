import 'package:grebo/core/service/repo/notificationRepo.dart';
import 'package:grebo/ui/screens/notifications/model/notificationModel.dart';

class NotificationController {
  late bool isNextNotification;
  NotificationController() {
    isNextNotification = true;
  }

  Future<List<Datum>> fetchNotification(int offset) async {
    if (offset == 0) isNextNotification = true;
    if (isNextNotification == false) return [];
    List<Datum> getNotify = [];
    var request = await NotificationRepo.fetchNotification();
    getNotify = request!.data;
    isNextNotification = request.hasMore;
    return getNotify;
  }
}
