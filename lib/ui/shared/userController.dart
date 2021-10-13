import 'package:get/get.dart';
import 'package:grebo/core/utils/appFunctions.dart';

import '../screens/login/model/currentUserModel.dart';

class UserController extends GetxController {
  late User _user;

  User get user => _user;

  set user(User value) {
    _user = value;
    updateDetails();
    update();
  }

  String _userToken = "";

  String get userToken => _userToken;

  set userToken(String value) {
    _userToken = value;
    update();
  }

  late List<Category> _globalCategory;

  List<Category> get globalCategory => _globalCategory;

  set globalCategory(List<Category> value) {
    _globalCategory = value;
    update();
  }

  List<String> getAvailabilityDay = [];

  void updateDetails() {
    print("update userController");
    getAvailabilityDay.clear();
    for (int i = 0; i < user.workingDays.length; i++) {
      var v = user.workingDays[i] - 1;
      for (int j = 0; j < 7; j++) {
        if (v == j) {
          getAvailabilityDay.add(weekDayList[v]);
        }
      }
    }
  }
}
