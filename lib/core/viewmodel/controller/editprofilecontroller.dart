import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/models/countrymodel.dart';

class EditBProfileController extends GetxController {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    update();
  }

  final PageController pageController = PageController(initialPage: 0);
  late CountryModel _selectedCountry;
  CountryModel get selectedCountry => _selectedCountry;
  set selectedCountry(CountryModel value) {
    _selectedCountry = value;
    update();
  }

  List<CountryModel>? _countries;
  List<CountryModel>? get countries => _countries;
  set countries(List<CountryModel>? value) {
    _countries = value;
    update();
  }

  List? _websites = [];
  List? get websites => _websites;
  set websites(List? value) {
    _websites = value;
    update();
  }

  String _kDefaultCountry = '+91';

  String get kDefaultCountry => _kDefaultCountry;

  set kDefaultCountry(String value) {
    _kDefaultCountry = value;
    update();
  }

  String? _selectValue;

  String? get selectValue => _selectValue;

  set selectValue(String? value) {
    _selectValue = value;
    update();
  }

  Color _defaultColor = Color(0xff8F92A3);

  Color get defaultColor => _defaultColor;

  set defaultColor(Color value) {
    _defaultColor = value;
    update();
  }

  void loadCountryJsonFile() async {
    print("loadCountryJsonFile....");
    var jsonText = await rootBundle.loadString(AppJson.country);
    countries = countryModelFromJson(jsonText);

    // List data = json.decode(jsonText);
    // print(data);

    // data.forEach(
    //   (element) {
    //     CountryModel countryModel = CountryModel.fromJson(element);
    //     if (countryModel.name!.toLowerCase() ==
    //         kDefaultCountry.toString().toLowerCase())
    //       _selectedCountry = countryModel;
    //   },
    // );
  }

  @override
  void onInit() {
    loadCountryJsonFile();
    super.onInit();
  }
}
