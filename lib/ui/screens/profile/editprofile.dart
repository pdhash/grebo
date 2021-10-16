import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/profile/controller/ProfileChangeController.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';
import 'package:grebo/ui/shared/customtextfield.dart';

import '../../../main.dart';
import '../../global.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ProfileChangeController profileChangeController =
      Get.put(ProfileChangeController());
  @override
  void dispose() {
    appImagePicker.imagePickerController.resetImage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('edit_profile'.tr),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: FadeInImage(
                          placeholder: AssetImage(AppImages.placeHolder),
                          image: controller.image == null
                              ? NetworkImage(
                                  "${imageUrl + userController.user.picture}")
                              : FileImage(controller.image as File)
                                  as ImageProvider,
                          height: 94,
                          width: 94,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppImages.placeHolder,
                              height: 122,
                              width: 122,
                              fit: BoxFit.cover,
                            );
                          },
                          fit: BoxFit.cover,
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
              CustomTextField(
                  controller: profileChangeController.name,textCapitalization: TextCapitalization.sentences,
                  hintText: 'John smith'),
              getHeightSizedBox(h: 18),
              Text(
                'email'.tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(16)),
              ),
              CustomTextField(
                controller: profileChangeController.email,
                hintText: 'johnsmith@gmail.com',
                enabled: false,
              ),
              getHeightSizedBox(h: 18),
              userController.user.userType ==
                      getServiceTypeCode(ServicesType.userType)
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
                            controller: profileChangeController.location,
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
                    onTap: () {
                      profileChangeController.updateUser();
                    }),
              ),
              getHeightSizedBox(h: 15)
            ],
          ),
        ),
      ),
    );
  }
}
