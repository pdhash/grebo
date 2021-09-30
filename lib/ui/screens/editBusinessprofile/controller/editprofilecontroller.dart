import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/models/countrymodel.dart';

class EditBProfileController extends GetxController {
  Future sendBusinessDetail() async {}

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

  ///--------------------------------------websites add
  List<String> websites = <String>[];
  void addWebsite(String str) {
    websites.add(str);
    update();
  }

  void removeWebsite(val) {
    websites.remove(val);
    update();
  }

  ///---------------------------------------------------country update
  String _kDefaultCountry = '+91';

  String get kDefaultCountry => _kDefaultCountry;

  set kDefaultCountry(String value) {
    _kDefaultCountry = value;
    update();
  }

  ///-------------------------------------------------

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
  }

  @override
  void onInit() {
    loadCountryJsonFile();
    super.onInit();
  }
}
