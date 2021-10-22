import 'package:get/get.dart';
import 'package:grebo/core/service/repo/postRepo.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/utils/appFunctions.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

class BusinessController extends GetxController {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    update();
  }

  List<String> getAvailabilityDay = [];
  List<String> getCloseDay = [];

  String businessRef = "";
  UserModel userModel =
      userController.user.userType == getServiceTypeCode(ServicesType.userType)
          ? UserModel()
          : userController.user;

  Future fetchUserDetail() async {
    var response = await PostRepo.fetchUserDetail(businessRef);
    if (response != null) {
      userModel = response;
      getAvailabilityDay.clear();
      for (int i = 0; i < userModel.workingDays.length; i++) {
        var v = userModel.workingDays[i] - 1;
        for (int j = 0; j < 7; j++) {
          if (v == j) {
            getAvailabilityDay.add(weekDayList[v]);
          }
        }
      }
      getCloseDay = weekDayList
          .where((element) => !getAvailabilityDay.contains(element))
          .toList();
      update();
    }
  }

  Future follow() async {
    var response = await PostRepo.followProvider(businessRef, true);
    if (response != null) {
      flutterToast(response["message"]);
    }
  }
}
