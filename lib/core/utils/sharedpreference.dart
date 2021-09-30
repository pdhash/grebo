import 'package:get_storage/get_storage.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

final sharedPreference = GetStorage();

saveUserDetails(Datum data) {
  userController.user = data.user;
  sharedPreference.write("GreboUser", data.user);
  sharedPreference.write("UserToken", data.accessToken);
}

bool getUserDetail() {
  var userData = sharedPreference.read("GreboUser");
  var userToken = sharedPreference.read("UserToken");
  if (userData == null) {
    return false;
  } else {
    userController.user = User.fromJson(userData);
    userController.userToken = userToken;
    return true;
  }
}
