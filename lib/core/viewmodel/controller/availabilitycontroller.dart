import 'package:get/get.dart';

class AvailabilityController extends GetxController {
  List<int> daysCount = [];

  void addDays(int index) {
    daysCount.add(index);
    update();
  }

  void removeDays(int index) {
    daysCount.removeWhere((element) => element == index);
    update();
  }

  ///=====================
  String _defaultTime = "00:00 AM";

  String get defaultTime => _defaultTime;

  set defaultTime(String value) {
    _defaultTime = value;
    update();
  }

  String _defaultTimeEnd = "00:00 PM";

  String get defaultTimeEnd => _defaultTimeEnd;

  set defaultTimeEnd(String value) {
    _defaultTimeEnd = value;
    update();
  }
}
