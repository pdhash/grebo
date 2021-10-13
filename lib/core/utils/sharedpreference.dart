import 'package:get_storage/get_storage.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

final sharedPreference = GetStorage();

saveUserDetails(Datum data) async {
  userController.user = data.user;
  await sharedPreference.write("GreboUser", data.user.toJson());

  await sharedPreference.write("UserToken", data.accessToken);
}

updateUserDetail(User user) async {
  userController.user = user;
  await sharedPreference.write("GreboUser", user.toJson());
}

removerUserDetail() async {
  await sharedPreference.remove("GreboUser");
  await sharedPreference.remove("UserToken");
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
