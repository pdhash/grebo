import 'package:get/get.dart';

import '../screens/login/model/currentUserModel.dart';

class UserController extends GetxController {
  late User _user;

  User get user => _user;

  set user(User value) {
    _user = value;
    update();
  }

  late String _userToken;

  String get userToken => _userToken;

  set userToken(String value) {
    _userToken = value;
    update();
  }
}
