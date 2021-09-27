import 'package:get/get.dart';

import 'login/model/currentUserModel.dart';

class UserController extends GetxController {
  late User _user;

  User get user => _user;

  set user(User value) {
    _user = value;
    update();
  }
}
