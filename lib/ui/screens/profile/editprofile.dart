import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/homeTab/controller/homeController.dart';
import 'package:grebo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';
import 'package:grebo/ui/shared/customtextfield.dart';

import '../../../main.dart';

class EditProfile extends StatelessWidget {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController location = TextEditingController();
  final HomeController homeScreenController = Get.find<HomeController>();

  final AppImagePicker appImagePicker = AppImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('edit_profile'.tr),
      body: SingleChildScrollView(
        child: Form(
          key: globalKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder(
                  builder: (ImagePickerController controller) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          disposeKeyboard();
                          appImagePicker.openBottomSheet();
                        },
                        child: Container(
                          height: getProportionateScreenWidth(94),
                          width: getProportionateScreenWidth(94),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: controller.image == null
                                ? DecorationImage(
                                    image: NetworkImage(
                                        imageUrl + userController.user.picture),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: FileImage(controller.image as File),
                                    fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                getHeightSizedBox(h: 10),
                Center(
                  child: Text(
                    'change_image'.tr,
                    style: TextStyle(fontSize: getProportionateScreenWidth(14)),
                  ),
                ),
                getHeightSizedBox(h: 30),
                Text(
                  'name'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(16)),
                ),
                Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                CustomTextField(controller: name, hintText: 'John smith'),
                getHeightSizedBox(h: 18),
                Text(
                  'email'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(16)),
                ),
                Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                CustomTextField(
                  controller: email,
                  hintText: 'johnsmith@gmail.com',
                  enabled: false,
                ),
                getHeightSizedBox(h: 18),
                userController.user.userType == 1
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'location'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenWidth(16)),
                          ),
                          Get.height < 800
                              ? getHeightSizedBox(h: 10)
                              : SizedBox(),
                          CustomTextField(
                              controller: location,
                              enabled: false,
                              onFieldTap: () {
                                print('hello');
                              },
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
                        ],
                      )
                    : SizedBox(),
                getHeightSizedBox(h: 280),
                SafeArea(
                  child: CustomButton(
                      type: CustomButtonType.colourButton,
                      text: 'save'.tr,
                      onTap: () {}),
                ),
                getHeightSizedBox(h: 15)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
