import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';

class AddServicesModel {
  final String? image;
  final String? title;

  AddServicesModel({this.image = "", this.title = ""});
}

class AddServiceController extends GetxController {
  List<AddServiceView> addServiceViews = [];
  List<AddServicesModel> serviceMultiFile = [];
  addDefault() {
    if (serviceMultiFile.length == 0) {
      addServiceViews = [AddServiceView(index: 0)];
      serviceMultiFile = <AddServicesModel>[AddServicesModel()];
    }
  }

  add() {
    print(addServiceViews.length);
    if (addServiceViews[addServiceViews.length - 1]
            .textController
            .text
            .isNotEmpty &&
        addServiceViews[addServiceViews.length - 1]
                .appImagePicker
                .imagePickerController
                .image !=
            null) {
      serviceMultiFile.add(AddServicesModel());
      addServiceViews.add(AddServiceView(
        index: addServiceViews.length,
      ));
    } else
      print('not valid');
    update();
  }

  bool finaAdd() {
    return addServiceViews[addServiceViews.length - 1]
            .textController
            .text
            .isNotEmpty &&
        addServiceViews[addServiceViews.length - 1]
                .appImagePicker
                .imagePickerController
                .image !=
            null;
  }

  remove(int index) {
    addServiceViews[index].appImagePicker.imagePickerController.resetImage();
    serviceMultiFile.removeAt(index);
    addServiceViews.removeAt(index);

    addServiceViews.asMap().forEach((int index, AddServiceView view) {
      view.index = index;
    });
    update();
  }
}

class AddServiceView extends StatefulWidget {
  final TextEditingController textController = TextEditingController();

  late final AppImagePicker appImagePicker;
  final AddServiceController addServiceController =
      Get.find<AddServiceController>();
  late String tag;

  int index;
  AddServiceView({required this.index});

  @override
  _AddServiceViewState createState() => _AddServiceViewState();
}

class _AddServiceViewState extends State<AddServiceView> {
  @override
  void initState() {
    super.initState();
    widget.tag = "AddServiceView${widget.index}";
    widget.appImagePicker = AppImagePicker(tag: widget.tag);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePickerController>(
      tag: widget.tag,
      builder: (controller) {
        File? image = widget.appImagePicker.imagePickerController.image;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () async {
                        widget.appImagePicker
                            .openBottomSheet(context: context, multiple: false);
                      },
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: getProportionateScreenWidth(66),
                                width: getProportionateScreenWidth(66),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.55),
                                            BlendMode.dstATop),
                                        image: FileImage(
                                          image,
                                        ),
                                        fit: BoxFit.cover)),
                                child: Center(
                                  child: Text(
                                    'change'.tr,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            getProportionateScreenWidth(11)),
                                  ),
                                ),
                              ),
                            )
                          : buildWidget(AppImages.uploadImage2, 66, 66)),
                  SizedBox(width: 10),
                  Expanded(
                      child: TextField(
                    minLines: 1,
                    maxLines: 2,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    controller: widget.textController,
                    cursorHeight: 15,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'name_of_service'.tr,
                        hintStyle: TextStyle(fontSize: 15)),
                  )),
                  SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        widget.addServiceController.remove(widget.index);
                      },
                      child: buildWidget(AppImages.closeGreen, 24, 24))
                ],
              ),
            ),
            SizedBox(height: 15),
            Divider(
              height: 0,
            ),
            SizedBox(height: 23),
          ],
        );
      },
    );
  }
}
