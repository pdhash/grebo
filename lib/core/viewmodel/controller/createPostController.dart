import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  String? _image;
  String? get image => _image;
  set image(String? value) {
    _image = value;
    update();
  }

  bool? isImage;

  browseImage(ImageSource imageSource, bool isVideo) async {
    ImagePicker imagePicker = ImagePicker();
    if (isVideo) {
      isImage = false;
      var pickedVideo = await imagePicker.pickVideo(source: imageSource);

      _image = pickedVideo!.path;
      update();
    } else {
      isImage = true;

      var pickedFile =
          await imagePicker.pickImage(source: imageSource, imageQuality: 50);
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
      image = file!.path;
      update();
    }
  }

  void openBottomSheet({required BuildContext context, required bool isVideo}) {
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
                browseImage(ImageSource.camera, isVideo);

                Get.back();
                image = null;
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'Gallery',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                browseImage(ImageSource.gallery, isVideo);

                Get.back();
                image = null;
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
                  browseImage(ImageSource.gallery, isVideo);

                  Get.back();
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
                  browseImage(ImageSource.camera, isVideo);
                  Get.back();
                },
              ),
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.3),
      );
  }
}
