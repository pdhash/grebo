import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:grebo/ui/screens/login/controller/signupcontroller.dart';
import 'package:grebo/ui/screens/login/login.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';
import 'package:grebo/ui/shared/customtextfield.dart';
import 'package:grebo/ui/shared/postview.dart';

class SignUp extends StatelessWidget {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final SignUpController signUpController = Get.put(SignUpController());
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  final AppImagePicker appImagePicker = AppImagePicker();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        disposeKeyboard();
      },
      child: GetBuilder(
        builder: (SignUpController controller) {
          if (controller.emailVer) {
            return Scaffold(
              appBar: appBar('Register'),
              body: Form(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        profileUpload(context),
                        getHeightSizedBox(h: 28),
                        header(
                          'name'.tr,
                        ),
                        nameField(),
                        getHeightSizedBox(h: 18),
                        header(
                          'email'.tr,
                        ),
                        emailField(),
                        getHeightSizedBox(h: 18),
                        header(
                          'password'.tr,
                        ),
                        passwordField(),
                        getHeightSizedBox(h: 18),
                        header(
                          'confirm_password'.tr,
                        ),
                        confirmPasswordField(),
                        getHeightSizedBox(h: 200),
                        CustomButton(
                            type: CustomButtonType.colourButton,
                            text: 'Signup'.tr,
                            onTap: () {
                              controller.emailVer = false;
                            }),
                        getHeightSizedBox(h: 20),
                        toLoginText(),
                        getHeightSizedBox(h: 40)
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: getProportionateScreenWidth(171),
                      width: getProportionateScreenWidth(171),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        AppImages.emailVer,
                        fit: BoxFit.fill,
                      ),
                    ),
                    getHeightSizedBox(h: 28),
                    Text(
                      'email_verify..'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          fontSize: getProportionateScreenWidth(20)),
                    ),
                    getHeightSizedBox(h: 30),
                    CustomButton(
                        type: CustomButtonType.colourButton,
                        text: 'ok'.tr,
                        onTap: () {
                          Get.back();

                          controller.emailVer = true;
                        }),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Center toLoginText() {
    return Center(
      child: Wrap(
        children: [
          Text('already_have'.tr,
              style: TextStyle(
                  color: AppColor.kDefaultFontColor.withOpacity(0.4),
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(15))),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text('login'.tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(15))),
          )
        ],
      ),
    );
  }

  Obx confirmPasswordField() {
    return Obx(
      () => CustomTextField(
        controller: signUpController.confirmPassword,
        hintText: 'XXXXXXXX',
        suffixWidth: 40,
        keyboardType: TextInputType.visiblePassword,
        obSecureText: signUpController.showText2.value,
        suffix: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            signUpController.showText2.toggle();
          },
          icon: Text(
            signUpController.showText2.value ? 'show'.tr : 'hide'.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Obx passwordField() {
    return Obx(() => CustomTextField(
          controller: signUpController.password,
          suffixWidth: 40,
          hintText: 'XXXXXXXX',
          keyboardType: TextInputType.visiblePassword,
          obSecureText: signUpController.showText.value,
          suffix: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              signUpController.showText.toggle();
            },
            icon: Text(
              signUpController.showText.value ? 'show'.tr : 'hide'.tr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  emailField() {
    return CustomTextField(
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        controller: signUpController.email,
        hintText: 'johnsmith@gmail.com');
  }

  nameField() {
    return CustomTextField(
      controller: signUpController.name,
      hintText: 'John smith',
      textCapitalization: TextCapitalization.sentences,
    );
  }

  profileUpload(BuildContext context) {
    return GetBuilder(
      builder: (ImagePickerController controller) {
        return Center(
          child: GestureDetector(
            onTap: () {
              disposeKeyboard();
              appImagePicker.openBottomSheet();
            },
            child: appImagePicker.imagePickerController.image == null
                ? Container(
                    height: 94,
                    width: 94,
                    child: SvgPicture.asset(
                      AppImages.upload,
                      fit: BoxFit.fill,
                    ),
                  )
                : uploadProfile(
                    image: controller.image.toString(), height: 94, width: 94),
          ),
        );
      },
    );
  }
}
