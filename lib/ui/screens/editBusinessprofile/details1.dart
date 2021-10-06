import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:grebo/ui/screens/editBusinessprofile/controller/editprofilecontroller.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/shared/alertdialogue.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';
import 'package:grebo/ui/shared/customtextfield.dart';

import '../../global.dart';
import 'details 2.dart';

class DetailsPage1 extends StatelessWidget {
  final bool isNext;

  final EditBProfileController editProfileController =
      Get.put(EditBProfileController());

  DetailsPage1({Key? key, this.isNext = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding - 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageSelectGrid(),
                getHeightSizedBox(h: 18),
                header('business_name'.tr),
                Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                nameField(),
                getHeightSizedBox(h: 18),
                header('business_category'.tr),
                categorySelect(),
                getHeightSizedBox(h: 18),
                header('phone_number'.tr),
                countryField(),
                getHeightSizedBox(h: 18),
                header('description'.tr),
                descField(),
                getHeightSizedBox(h: 18),
                header('location'.tr),
                locationFiled(),
                getHeightSizedBox(h: 18),
                websiteHeader(),
                getHeightSizedBox(h: 16),
                getHeightSizedBox(h: 10),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Color(0xffA4A4A4),
                ),
                getHeightSizedBox(h: 30),
                CustomButton(
                    type: CustomButtonType.colourButton,
                    text: 'save'.tr,
                    onTap: () {
                      if (isNext) {
                        appImagePicker.imagePickerController.resetImage();
                        Get.to(() => DetailsPage2());
                      } else {
                        appImagePicker.imagePickerController.resetImage();
                        Get.back();
                      }
                    }),
                getHeightSizedBox(h: 40),
              ],
            )));
  }

  websites() {
    return GetBuilder(
      builder: (EditBProfileController controller) {
        return controller.websites.isEmpty
            ? SizedBox()
            : Column(
                children: controller.websites
                    .map((e) => FittedBox(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 7),
                            height: getProportionateScreenWidth(26),
                            width: getProportionateScreenWidth(165),
                            decoration: BoxDecoration(
                                color: Color(0xff009345),
                                borderRadius: BorderRadius.circular(13)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  getHeightSizedBox(w: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        e,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    12)),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.removeWebsite(e);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  getHeightSizedBox(w: 10)
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              );
      },
    );
  }

  websiteHeader() {
    return GetBuilder(
      builder: (EditBProfileController controller) => Row(
        children: [
          header('website_links'.tr),
          Spacer(),
          GestureDetector(
            onTap: () {
              dialogueOpen(
                  controller: controller.weblinks,
                  context: Get.context as BuildContext,
                  onCancel: () {
                    Get.back();
                  },
                  onOk: () {
                    if (controller.weblinks.text == '') {
                      Get.back();
                    } else {
                      controller.addWebsite(controller.weblinks.text);
                      Get.back();
                      controller.weblinks.clear();
                    }
                  });
            },
            child: Wrap(
              //  crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  '+',
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      color: AppColor.kDefaultFontColor.withOpacity(0.74)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    'add'.tr,
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: AppColor.kDefaultFontColor.withOpacity(0.74)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  locationFiled() {
    return CustomTextField(
        controller: editProfileController.location,
        enabled: false,
        onFieldTap: () {
          print('hello');
        },
        hintText: 'Villaz Johns Street 11, California..',
        textSize: 14,
        suffixWidth: 19,
        suffix: GestureDetector(
          onTap: () {
            print('ok');
          },
          child: Container(
              padding: EdgeInsets.all(0),
              child: buildWidget(AppImages.gps, 19, 19)),
        ));
  }

  descField() {
    return TextFormField(
      controller: editProfileController.description,
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.sentences,
      maxLines: 2,
      minLines: 1,
      decoration: InputDecoration(
          hintStyle: TextStyle(
              fontSize: getProportionateScreenWidth(14),
              color: Color(0xff8F92A3)),
          hintText:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
    );
  }

  categorySelect() {
    return SizedBox(
      height: 45,
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
        value: 2,
        onTap: () {
          disposeKeyboard();
        },
        icon: buildWidget(AppImages.dropdownClose, 10, 20),
        onChanged: (val) {},
        items: <DropdownMenuItem<int>>[
          DropdownMenuItem<int>(
            value: 1,
            child: Text(
              "Owner",
              style: TextStyle(fontSize: getProportionateScreenWidth(14)),
            ),
          ),
          DropdownMenuItem<int>(
            value: 2,
            child: Text("Member",
                style: TextStyle(fontSize: getProportionateScreenWidth(14))),
          ),
        ],
      ),
    );
  }

  nameField() {
    return CustomTextField(
      controller: editProfileController.businessName,
      textCapitalization: TextCapitalization.sentences,
      hintText: 'Smith Hospitality',
      textSize: 14,
    );
  }

  imageSelectGrid() {
    return AspectRatio(
        aspectRatio: 1.8,
        child: GetBuilder(
          builder: (ImagePickerController controller) => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 100 / 80),
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: 10,
              ),
              clipBehavior: Clip.none,
              itemCount: 6,
              itemBuilder: (context, index) => controller.multiFile.length >
                      (index)
                  ? Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: AspectRatio(
                            aspectRatio: 100 / 80,
                            child: Image.file(
                              File(controller.multiFile[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                            right: -4,
                            top: -4,
                            child: GestureDetector(
                              onTap: () {
                                controller.removeImage(index);
                              },
                              child: buildWidget(AppImages.closeGreen, 16, 16),
                            ))
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        appImagePicker.openBottomSheet(
                          context: context,
                          multiple: true,
                        );
                      },
                      child: buildWidget(AppImages.uploadImage, 80, 100))),
        ));
  }

  countryField() {
    return GetBuilder(
      builder: (EditBProfileController controller) => TextFormField(
        controller: controller.mobileNumber,
        style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.phone,
        textAlignVertical: TextAlignVertical.center,
        buildCounter: (BuildContext context,
                {required int currentLength,
                required bool isFocused,
                required int? maxLength}) =>
            null,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10, top: 2),
            hintStyle: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                color: AppColor.kDefaultFontColor.withOpacity(0.5)),
            hintText: '987654321',
            prefixIcon: GestureDetector(
              onTap: () {},
              child: Row(
                children: [],
              ),
            )),
      ),
    );
  }

  customAppBar() {
    return appBar(
      'business_details'.tr,
      [
        isNext
            ? Padding(
                padding: const EdgeInsets.only(top: 22, right: 25),
                child: Text(
                  '1 of 3',
                  style: TextStyle(
                      color: AppColor.kDefaultFontColor.withOpacity(0.72),
                      fontSize: 15),
                ),
              )
            : SizedBox()
      ],
    );
  }
}

Widget header(String title) {
  return Text(
    title,
    style: TextStyle(
        fontSize: getProportionateScreenWidth(16), fontWeight: FontWeight.bold),
  );
}
