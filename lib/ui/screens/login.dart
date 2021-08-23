import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/homescreencontroller.dart';
import 'package:grebo/core/viewmodel/controller/loginController.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/ui/screens/signup.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';
import 'package:grebo/ui/shared/customtextfield.dart';

import 'forgotpassword.dart';
import 'mainscreen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final LoginController loginController = Get.put(LoginController());
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(ServicesType.userType ==
              homeScreenController.serviceController.servicesType
          ? 'user_login'.tr
          : 'service_provider_login'.tr),
      body: Form(
        key: globalKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getHeightSizedBox(h: 10),
                      Text(
                        'get_started'.tr,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(22)),
                      ),
                      getHeightSizedBox(h: 12),
                      Text(
                        'enter_your..'.tr,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            color: AppColor.kDefaultFontColor.withOpacity(0.7)),
                      ),
                      getHeightSizedBox(h: 20),
                      Text(
                        'email_address'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(18)),
                      ),
                      Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                      CustomTextField(
                          controller: email,
                          hintText: 'email_example'.tr,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                              val!.isValidEmail() ? null : 'check_your_email'),
                      getHeightSizedBox(h: 24),
                      Text(
                        'password'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(18)),
                      ),
                      Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                      Obx(
                        () => CustomTextField(
                          hintText: 'password_example'.tr,
                          suffixWidth: 40,
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          obSecureText: loginController.showText.value,
                          suffix: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              loginController.showText.toggle();
                            },
                            icon: Text(
                              loginController.showText.value
                                  ? 'show'.tr
                                  : 'hide'.tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          validator: (val) {},
                        ),
                      ),
                      getHeightSizedBox(h: 21),
                      GestureDetector(
                        onTap: () {
                          disposeKeyboard();

                          Get.to(() => ForgotPassword());
                        },
                        child: Center(
                            child: Text(
                          'forgot_your_password'.tr,
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(16)),
                        )),
                      ),
                      getHeightSizedBox(h: 27),
                      CustomButton(
                          padding: 5,
                          type: CustomButtonType.colourButton,
                          text: 'login'.tr,
                          onTap: () {
                            disposeKeyboard();
                            Get.offAll(() => HomeScreen());
                            // if (homeScreenController
                            //         .serviceController.servicesType ==
                            //     ServicesType.userType)
                            //   Get.offAll(() => HomeScreen());
                            // else
                            //   Get.offAll(() => DetailsPage1());
                          }),
                      getHeightSizedBox(h: 20),
                      CustomButton(
                          padding: 5,
                          type: CustomButtonType.borderButton,
                          text: 'create_an_account'.tr,
                          onTap: () {
                            disposeKeyboard();
                            Get.to(() => SignUp());
                          }),
                      getHeightSizedBox(h: 23),
                      ServicesType.userType ==
                              homeScreenController
                                  .serviceController.servicesType
                          ? GestureDetector(
                              onTap: () {
                                disposeKeyboard();
                              },
                              child: Center(
                                child: Text(
                                  'continue_as_guest'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                      color: AppColor.kDefaultColor),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  )),
              getHeightSizedBox(h: 29),
              Row(
                children: [
                  Expanded(
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'or'.tr,
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(16)),
                    ),
                  ),
                  Expanded(
                    child: Divider(),
                  ),
                ],
              ),
              getHeightSizedBox(h: 23),
              Text(
                'continue_with..'.tr,
                style: TextStyle(fontSize: getProportionateScreenWidth(15)),
                textAlign: TextAlign.center,
              ),
              getHeightSizedBox(h: 23),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    socialButton(AppImages.facebook, () {
                      disposeKeyboard();
                    }),
                    socialButton(AppImages.google, () {
                      disposeKeyboard();
                    }),
                    socialButton(AppImages.apple, () {
                      disposeKeyboard();
                    }),
                  ],
                ),
              ),
              getHeightSizedBox(h: 20)
            ],
          ),
        ),
      ),
    );
  }
}
