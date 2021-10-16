import 'package:get_storage/get_storage.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

final sharedPreference = GetStorage();

saveUserDetails(Datum data) {
  print("From SHAREPREFRENCE ${data.accessToken}");
  userController.user = data.user;
  userController.userToken = data.accessToken;
  sharedPreference.write("GreboUser", data.user.toJson());
  sharedPreference.write("UserToken", data.accessToken);
}

updateUserDetail(User user) async {
  userController.user = user;
  sharedPreference.write("GreboUser", user.toJson());
}

removerUserDetail() async {
  sharedPreference.erase();
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
