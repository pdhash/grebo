import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/service/repo/postRepo.dart';
import 'package:grebo/ui/shared/loader.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class AddPostController extends GetxController {
  final TextEditingController postCaption = TextEditingController();

  File? _uploadFile;
  File? get uploadFile => _uploadFile;
  set uploadFile(File? value) {
    _uploadFile = value;
    update();
  }

  File? _thumbnail;

  File? get thumbnail => _thumbnail;

  set thumbnail(File? value) {
    _thumbnail = value;
    update();
  }

  Future addPost() async {
    print("ahgdhjgvshvds");
    var response;

    response = await PostRepo.postUpload(uploadFile as File,
        {"text": postCaption.text.trim()}, isImage, thumbnail);

    if (response != null) {
      print(response);
      return response;
    }
  }

  late bool _isImage;

  bool get isImage => _isImage;

  set isImage(bool value) {
    _isImage = value;
    update();
  }

  browseImage(ImageSource imageSource, bool isVideo) async {
    ImagePicker imagePicker = ImagePicker();
    if (isVideo) {
      isImage = false;
      var pickedVideo = await imagePicker.pickVideo(
        source: imageSource,
      );
      if (pickedVideo != null) {
        LoadingOverlay.of().show();
        MediaInfo? mediaInfo = await VideoCompress.compressVideo(
          pickedVideo.path,
          quality: VideoQuality.MediumQuality,
          deleteOrigin: true, // It's false by default
        );
        LoadingOverlay.of().hide();

        final uint8list = await VideoCompress.getFileThumbnail(
          mediaInfo!.path.toString(),
        );
        thumbnail = uint8list;

        uploadFile = File(mediaInfo.path.toString());
      }

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
      uploadFile = file;
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
                uploadFile = null;
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
                uploadFile = null;
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
