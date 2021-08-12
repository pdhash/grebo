import 'package:get/get.dart';

class DayModel {
  final String day;
  bool selected = false;

  DayModel({required this.selected, required this.day});
}

class AvailabilityController extends GetxController {
  List<DayModel> _list = [
    DayModel(selected: false, day: 'Mon'),
    DayModel(selected: false, day: 'Tue'),
    DayModel(selected: false, day: 'Wed'),
    DayModel(selected: false, day: 'Thu'),
    DayModel(selected: false, day: 'Fri'),
    DayModel(selected: false, day: 'Sat'),
    DayModel(selected: false, day: 'Sun'),
  ];

  List<DayModel> get list => _list;

  set list(List<DayModel> value) {
    _list = value;
    update();
  }

  void change(int index) {
    list[index].selected = !list[index].selected;
    update();
  }

  List<DayModel> get finalDays {
    return list.where((element) => element.selected).toList();
  }

  ///=====================
  String _defaultTime = "00:00 AM";

  String get defaultTime => _defaultTime;

  set defaultTime(String value) {
    _defaultTime = value;
    update();
  }

  String _defaultTimeEnd = "00:00 PM";

  String get defaultTimeEnd => _defaultTimeEnd;

  set defaultTimeEnd(String value) {
    _defaultTimeEnd = value;
    update();
  }
}
