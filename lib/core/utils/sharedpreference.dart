import 'package:geocoding/geocoding.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grebo/core/service/repo/postRepo.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/global.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

final sharedPreference = GetStorage();

saveUserDetails(Datum data) {
  userController.user = data.user;
  userController.userToken = data.accessToken;
  sharedPreference.write("GreboUser", data.user.toJson());
  sharedPreference.write("UserToken", data.accessToken);
}

saveUserLastLateLong(double late, double long) {
  sharedPreference.write("userLate", late);
  sharedPreference.write("userLong", long);
}

Location readLastLateLong() {
  return Location(
      latitude: sharedPreference.read("userLate"),
      longitude: sharedPreference.read("userLong"),
      timestamp: DateTime.now());
}

onBoardingHide() {
  sharedPreference.write("HideOnBoarding", true);
}

bool onBoardingHideRead() {
  if (sharedPreference.read("HideOnBoarding") == null) {
    return false;
  } else
    return true;
}

updateUserDetail(UserModel user) async {
  userController.user = user;
  sharedPreference.write("GreboUser", user.toJson());
}

removerUserDetail() async {
  sharedPreference.remove("GreboUser");
  sharedPreference.remove("UserToken");
  sharedPreference.remove("userLate");
  sharedPreference.remove("userLong");
}

Future getUserDetail() async {
  var userData = sharedPreference.read("GreboUser");
  var userToken = sharedPreference.read("UserToken");
  if (userData == null) {
    navigationScreen = false;
  } else {
    userController.user = UserModel.fromJson(userData);
    userController.userToken = userToken;
    if (!userController.user.verifiedByAdmin) {
      final p =
          await PostRepo.fetchUserDetail(businessRef: userController.user.id);
      if (p != null) {
        if (p.verifiedByAdmin) {
          updateUserDetail(p);
        }
      }
    }
    navigationScreen = true;
  }
}
