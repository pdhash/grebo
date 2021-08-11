import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/editprofilecontroller.dart';
import 'package:greboo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:greboo/ui/screens/homeTab/home.dart';
import 'package:greboo/ui/shared/alertdialogue.dart';
import 'package:greboo/ui/shared/customtextfield.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

class DetailsPage1 extends StatelessWidget {
  final AppImagePicker appImagePicker = AppImagePicker();
  final TextEditingController businessName = TextEditingController();
  final TextEditingController businessCategory = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController weblinks = TextEditingController();
  final EditBProfileController editBProfileController = Get.find();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return KeyBoardSettings(
        focusNode1: _nodeText1,
        focusNode2: _nodeText2,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding - 5),
          child: GetBuilder(
            builder: (EditBProfileController controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.8,
                    child: GetBuilder(
                      builder: (ImagePickerController controller) {
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 100 / 80),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            itemBuilder: (context, index) => controller
                                        .multiFile!.length >
                                    (index)
                                ? Image.file(File(controller.multiFile![index]))
                                : GestureDetector(
                                    onTap: () {
                                      appImagePicker.openBottomSheet(
                                        context: context,
                                        multiple: false,
                                      );
                                    },
                                    child: buildWidget(
                                        AppImages.uploadImage, 80, 100)));
                      },
                    ),
                  ),
                  getHeightSizedBox(h: 10),
                  header('business_name'.tr),
                  Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                  CustomTextField(
                    controller: businessName,
                    hintText: 'Smith Hospitality',
                    textSize: 14,
                  ),
                  getHeightSizedBox(h: 18),
                  header('business_category'.tr),
                  SizedBox(
                    height: 45,
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      value: 2,
                      icon: buildWidget(AppImages.dropdownClose, 10, 20),
                      onChanged: (val) {},
                      items: <DropdownMenuItem<int>>[
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text(
                            "Owner",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(14)),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text("Member",
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(14))),
                        ),
                      ],
                    ),
                  ),
                  getHeightSizedBox(h: 18),
                  header('phone_number'.tr),
                  Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                  CustomTextField(
                    controller: mobileNumber,
                    hintText: '987654321',
                    focusNode: _nodeText1,
                    keyboardType: TextInputType.phone,
                    textSize: 14,
                    prefix: controller.countries == null
                        ? SizedBox()
                        : DropdownButton<String>(
                            focusColor: Colors.white,
                            underline: SizedBox(),
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,

                            items: List.generate(
                              controller.countries!.length,
                              (index) => DropdownMenuItem<String>(
                                value: controller.countries![index].code,
                                onTap: () {
                                  controller.kDefaultCountry = controller
                                      .countries![index].dialCode as String;
                                  controller.defaultColor =
                                      AppColor.kDefaultFontColor;
                                },
                                child: Text(
                                  '${controller.countries![index].dialCode}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          getProportionateScreenWidth(14)),
                                ),
                              ),
                            ),

                            hint: Row(
                              children: [
                                Text(
                                  controller.kDefaultCountry,
                                  style: TextStyle(
                                      color: controller.defaultColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                getHeightSizedBox(w: 4),
                                buildWidget(AppImages.dropdownClose, 9, 18),
                                getHeightSizedBox(w: 4),
                              ],
                            ),
                            icon: SizedBox(),
                            //icon: buildWidget(AppImages.dropdownClose, 8, 17),
                            onChanged: (val) {},
                          ),
                  ),
                  getHeightSizedBox(h: 18),
                  header('description'.tr),
                  TextFormField(
                    controller: description,
                    focusNode: _nodeText2,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 2,
                    minLines: 1,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: Color(0xff8F92A3)),
                        hintText:
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
                  ),
                  getHeightSizedBox(h: 18),
                  header('location'.tr),
                  Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                  CustomTextField(
                      controller: businessName,
                      hintText: 'Villaz Johns Street 11, California..',
                      textSize: 14,
                      suffixWidth: 19,
                      suffix: GestureDetector(
                        // alignment: Alignment.centerRight,
                        onTap: () {
                          print('ok');
                        },
                        //padding: EdgeInsets.zero,
                        child: Container(
                            padding: EdgeInsets.all(0),
                            //color: Colors.red,
                            //alignment: Alignment.centerRight,
                            child: buildWidget(AppImages.gps, 19, 19)),
                      )),
                  getHeightSizedBox(h: 18),
                  Row(
                    children: [
                      header('website_links'.tr),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          dialogueOpen(
                              controller: weblinks,
                              context: context,
                              onCancel: () {
                                Get.back();
                              },
                              onOk: () {});
                        },
                        child: Wrap(
                          //  crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              '+',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(20),
                                  color: AppColor.kDefaultFontColor
                                      .withOpacity(0.74)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                'add'.tr,
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(15),
                                    color: AppColor.kDefaultFontColor
                                        .withOpacity(0.74)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  getHeightSizedBox(h: 16),
                  getHeightSizedBox(h: 10),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: Color(0xffA4A4A4),
                  ),
                  getHeightSizedBox(h: 28),
                ],
              );
            },
          ),
        ));
  }

  Widget header(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: getProportionateScreenWidth(16),
          fontWeight: FontWeight.bold),
    );
  }
}

class KeyBoardSettings extends StatelessWidget {
  final Widget child;
  final FocusNode focusNode1;
  final FocusNode focusNode2;

  KeyBoardSettings(
      {Key? key,
      required this.child,
      required this.focusNode1,
      required this.focusNode2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: KeyboardActionsConfig(
          keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
          keyboardBarColor: Colors.grey[200],
          actions: [
            KeyboardActionsItem(
                focusNode: focusNode1,
                displayArrows: false,
                toolbarButtons: [
                  (node) {
                    return CupertinoButton(
                      padding: EdgeInsets.zero.copyWith(right: 20),
                      onPressed: () => node.unfocus(),
                      child: Text(
                        'Done',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    );
                  },
                ]),
            KeyboardActionsItem(
                focusNode: focusNode2,
                displayArrows: false,
                toolbarButtons: [
                  (node) {
                    return CupertinoButton(
                      padding: EdgeInsets.zero.copyWith(right: 20),
                      onPressed: () => node.unfocus(),
                      child: Text(
                        'Done',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    );
                  },
                ])
          ]),
      child: child,
    );
  }
}
