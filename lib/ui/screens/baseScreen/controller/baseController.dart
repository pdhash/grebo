import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:grebo/core/utils/sharedpreference.dart';
import 'package:grebo/ui/global.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/messagesTab/allmessages.dart';
import 'package:grebo/ui/screens/notifications/notifications.dart';
import 'package:grebo/ui/shared/location.dart';

class BaseController extends GetxController {
  double latitude = 0;
  double longitude = 0;

  int _current = initialTab;

  int get currentTab => _current;

  set currentTab(int value) {
    _current = value;
    if (value == 1) {
      AllMessages.paginationKey.currentState!.refresh();
    } else if (value == 2) {
      AllNotification.paginationKey.currentState!.refresh();
    }
    update();
  }

  resetInitialTab() {
    currentTab = 0;
  }

  String _address = "";

  String get address => _address;

  set address(String value) {
    _address = value;
    update();
  }

  String _baseAddress = "";

  String get baseAddress => _baseAddress;

  set baseAddress(String value) {
    _baseAddress = value;
    update();
  }

  changeAddress(double lat, double long, String address) {
    this.latitude = lat;
    this.longitude = long;
    this.address = address;
    Home.paginationViewKey.currentState!.refresh();
  }

  getAddressFromLatLong(LatLongCoordinate locationData) async {
    if (!locationData.isNull) {
      print("location is not null");
      saveUserLastLateLong(locationData.latitude!.toDouble(),
          locationData.longitude!.toDouble());
    }
    double? lat = locationData.latitude ?? readLastLateLong.call().latitude;
    double? long = locationData.longitude ?? readLastLateLong.call().longitude;
    print("lat ====================>>> $lat");
    print("long ====================>>> $long");
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(lat.toDouble(), long.toDouble());
    Placemark place = placeMarks[0];
    changeAddress(lat, long,
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}');
  }
}
