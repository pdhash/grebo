import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  // setImage(String url) async {
  //   if (url != "") {
  //     if (!url.startsWith("http"))
  //       _image = File(url);
  //     else {
  //       _image = await urlToFile(url);
  //     }
  //     update();
  //   }
  // }

  File? _image;
  File? get image => _image;
  set image(File? value) {
    _image = value;
    update();
  }

  void resetImage() {
    image = null;
  }

  List<String> multiFile = <String>[];

  void removeImage(int index) {
    multiFile.removeAt(index);
    update();
  }

  void multiAddImages(String image) {
    multiFile.add(image);
    update();
  }
}

class AppImagePicker {
  ImagePicker imagePicker = ImagePicker();
  String? tag;
  late ImagePickerController _imagePickerController;
  ImagePickerController get imagePickerController =>
      Get.find<ImagePickerController>(tag: tag);

  AppImagePicker({String? tag}) {
    this.tag = tag;
    _imagePickerController = Get.put(ImagePickerController(), tag: tag);
  }
  browseImage(ImageSource imageSource, bool isMulti) async {
    var pickedFile =
        await imagePicker.pickImage(source: imageSource, imageQuality: 50);
    if (isMulti == true) {
      File? file = await ImageCropper.cropImage(
        sourcePath: pickedFile!.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.white,
          toolbarTitle: "Image Cropper",
        ),
      );
      imagePickerController.multiAddImages(file!.path);
    } else {
      File? file = await ImageCropper.cropImage(
        sourcePath: pickedFile!.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.white,
          toolbarTitle: "Image Cropper",
        ),
      );
      imagePickerController.image = file;
    }
  }

  void openBottomSheet(
      {required BuildContext context, required bool multiple}) {
    if (Platform.isIOS)
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: Text(
                'Camera',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                browseImage(ImageSource.camera, multiple);

                Get.back();
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'Gallery',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                browseImage(ImageSource.gallery, multiple);

                Get.back();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      );
    else
      Get.bottomSheet(
        Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                tileColor: Colors.white,
                onTap: () async {
                  browseImage(ImageSource.gallery, multiple);
                  Get.back();

                  /*
                  var status = await Permission.photos.status;
                  print("STATUS ${status}");
                  // try {
                  if (status == PermissionStatus.denied) {
                    print("DENIED");
                    askPermissionAgain(Permission.photos);
                  } else if (status == PermissionStatus.permanentlyDenied) {
                    await openAppSettings();
                  } else if (status == PermissionStatus.granted ||
                      status == PermissionStatus.limited) {
                    print("GRNATED");
                    browseImage(ImageSource.gallery);
                  } else {
                    showMessage("restrictedAccessMsg".tr);
                  }
                 */
                },
              ),
              Divider(
                height: 0.5,
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                tileColor: Colors.white,
                onTap: () async {
                  Get.back();
                  browseImage(ImageSource.camera, multiple);

                  /*
                  var status = await Permission.camera.status;
                  print("STATUS ${status}");
                  // try {
                  if (status == PermissionStatus.denied) {
                    askPermissionAgain(Permission.camera);
                  } else if (status == PermissionStatus.permanentlyDenied) {
                    await openAppSettings();
                  } else if (status == PermissionStatus.granted ||
                      status == PermissionStatus.limited) {
                    browseImage(ImageSource.camera);
                  } else {
                    showMessage("restrictedAccessMsg".tr);
                  }
                   */
                },
              ),
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.3),
      );
  }
}
