import 'package:get/get.dart';

class ServiceController extends GetxController {
  late ServicesType _servicesType;

  ServicesType get servicesType => _servicesType;

  set servicesType(ServicesType value) {
    _servicesType = value;
    update();
  }
}

enum ServicesType {
  userType,
  providerType,
}
