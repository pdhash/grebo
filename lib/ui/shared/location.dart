import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grebo/core/utils/appFunctions.dart';
import 'package:grebo/ui/screens/baseScreen/controller/baseController.dart';
import 'package:location/location.dart';

class GetLocationController extends GetxController {
  GetLocationController() {
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Location currentLocation = new Location();
    LocationData _locationData;
    PermissionStatus permissionStatus = await currentLocation.hasPermission();

    print("getCurrentLocation $permissionStatus");
    try {
      getLocation() async {
        bool isServiceEnable = await Geolocator.isLocationServiceEnabled();
        print("GETTING LOCATION isServiceEnable $isServiceEnable");
        bool isShow = false;
        Timer.periodic(Duration(milliseconds: 500), (timer) async {
          if (!isShow) {
            isShow = true;
            _locationData = await currentLocation.getLocation();
          }

          // Stop the timer when it matches a condition
          isServiceEnable = await Geolocator.isLocationServiceEnabled();
          print("TIMER isServiceEnable ${isServiceEnable} ");
          if (isServiceEnable) {
            timer.cancel();
            _locationData = await currentLocation.getLocation();
            print("LOCATION $_locationData");
            Get.find<BaseController>().getAddressFromLatLong(_locationData);
          }
        });
      }

      if (permissionStatus != PermissionStatus.granted) {
        bool isShow = false;
        Timer.periodic(Duration(milliseconds: 500), (timer) async {
          if (!isShow) {
            isShow = true;
            _locationData = await currentLocation.getLocation();
          }
          // Stop the timer when it matches a condition
          permissionStatus = await currentLocation.hasPermission();
          print("TIMER permissionStatus ${permissionStatus} ");
          if (permissionStatus == PermissionStatus.granted) {
            timer.cancel();
            getLocation();
          }
        });
      }

      if (permissionStatus == PermissionStatus.granted) {
        getLocation();
      }
    } on PlatformException {
      print("PlatformException");
      flutterToast("allowAccessToLocationMsg".tr);
      if (permissionStatus != PermissionStatus.granted) {
        _locationData = await currentLocation.getLocation();
      }
    } catch (error) {
      print("error ${error}");
      flutterToast("allowAccessToLocationMsg".tr);
      if (permissionStatus != PermissionStatus.granted) {
        _locationData = await currentLocation.getLocation();
      }
    }
  }
}
