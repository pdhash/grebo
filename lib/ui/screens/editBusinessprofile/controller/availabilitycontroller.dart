import 'package:get/get.dart';
import 'package:grebo/core/service/repo/editProfileRepo.dart';

import '../details3.dart';

class AvailabilityController extends GetxController {
  List<int> daysCount = [];

  void addDays(int index) {
    print("add $daysCount");
    daysCount.add(index);
    update();
  }

  void removeDays(int index) {
    print("before list ${daysCount}");
    daysCount.remove(index);

    update();
    print("After list ${daysCount}");
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

  ///=============== DB
  String _startTime = "";

  String get startTime => _startTime;

  set startTime(String value) {
    _startTime = value;
    update();
  }

  String _endTime = "";

  String get endTime => _endTime;

  set endTime(String value) {
    _endTime = value;
    update();
  }

  Future submitAllFields() async {
    var v = await EditProfileRepo.updateUser(
      map: {
        "workingDays": daysCount,
        "startTime": startTime,
        "endTime": endTime,
      },
    );
    if (v != null) {
      Get.to(() => DetailsPage3());
    }
  }
}
