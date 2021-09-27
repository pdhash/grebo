import 'package:get_storage/get_storage.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

final sharedPreference = GetStorage();

saveUserDetails(User user) {
  userController.user = user;
  sharedPreference.write("GreboUser", user.toJson());
}

bool getUserDetail() {
  var userData = sharedPreference.read("GreboUser");
  if (userData == null) {
    return false;
  } else {
    userController.user = User.fromJson(userData);
    return true;
  }
}
