import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/models/countrymodel.dart';
import 'package:grebo/core/service/repo/editProfileRepo.dart';
import 'package:grebo/core/service/repo/imageRepo.dart';
import 'package:grebo/core/utils/appFunctions.dart';
import 'package:grebo/main.dart';

import '../../../global.dart';

class EditBProfileController extends GetxController {
  final TextEditingController businessName = TextEditingController();
  final TextEditingController businessCategory = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController weblinks = TextEditingController();

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

  //add websites
  List<String> websites = <String>[];
  void addWebsite(String str) {
    websites.add(str);
    update();
  }

  void removeWebsite(val) {
    websites.remove(val);
    update();
  }

  //country update
  late String _kDefaultCountry = '91';

  String get kDefaultCountry => _kDefaultCountry;

  set kDefaultCountry(String value) {
    _kDefaultCountry = value;
    update();
  }

  List<File> multiFile = <File>[];
  List<String> uploadMultiFile = [];

  void removeImage(int index) {
    multiFile.removeAt(index);
    uploadMultiFile.removeAt(index);
    update();
  }

  void multiAddImages(File file, String imageID) {
    multiFile.add(file);
    uploadMultiFile.add(imageID);
    update();
  }

  ///-------------------------------------------------

  String? _selectValue;

  String? get selectValue => _selectValue;

  set selectValue(String? value) {
    _selectValue = value;
    update();
  }

  late int _categorySelect;

  int get categorySelect => _categorySelect;

  set categorySelect(int value) {
    _categorySelect = value;
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

  uploadImage() {
    appImagePicker.imagePickerController.resetImage();
    appImagePicker.openBottomSheet().then((value) {
      if (appImagePicker.imagePickerController.image != null) {
        ImageRepo.uploadImage(
                fileImage: [appImagePicker.imagePickerController.image as File])
            .then((value) {
          flutterToast(value["message"]);
          multiAddImages(appImagePicker.imagePickerController.image as File,
              value["data"].toString());
        });
      }
    });
  }

  deleteImage(int index) {
    ImageRepo.deleteImage(imageId: uploadMultiFile[index]).then((value) {
      flutterToast(value["message"]);
      removeImage(index);
    });
  }

  Future submitAllFields() async {
    print(userController.user);
    var v = await EditProfileRepo.updateUser(
      map: {
        "name": "userName",
        "businessName": businessName.text.trim(),
        "images": uploadMultiFile,
        "latitude": 1,
        "longitude": 2,
        "websites": websites,
        "phoneCode": kDefaultCountry,
        "phoneNumber": mobileNumber.text.trim(),
        "description": description.text.trim(),
      },
    );
    if (v != null) {
      //saveUserDetails()
      //Get.to(() => DetailsPage2());
    }
  }

  @override
  void onInit() {
    loadCountryJsonFile();
    super.onInit();
  }
}
