import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/ui/screens/baseScreen/baseScreen.dart';
import 'package:grebo/ui/screens/login/controller/loginController.dart';
import 'package:grebo/ui/screens/login/signup.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';
import 'package:grebo/ui/shared/customtextfield.dart';

import '../../global.dart';
import 'widgets/forgotpassword.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        disposeKeyboard();
      },
      child: Scaffold(
        appBar: appBar(ServicesType.userType == serviceController.servicesType
            ? 'user_login'.tr
            : 'service_provider_login'.tr),
        body: Form(
          key: formKey,
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
                              color:
                                  AppColor.kDefaultFontColor.withOpacity(0.7)),
                        ),
                        getHeightSizedBox(h: 20),
                        header(
                          'email_address'.tr,
                        ),
                        emailField(),
                        getHeightSizedBox(h: 24),
                        header('password'.tr),
                        passwordFiled(),
                        getHeightSizedBox(h: 21),
                        forgotPasswordButton(),
                        getHeightSizedBox(h: 27),
                        loginButton(),
                        getHeightSizedBox(h: 20),
                        createAnAccountButton(),
                        getHeightSizedBox(h: 23),
                        ServicesType.userType == serviceController.servicesType
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
                orDivider(),
                getHeightSizedBox(h: 23),
                Text(
                  'continue_with..'.tr,
                  style: TextStyle(fontSize: getProportionateScreenWidth(15)),
                  textAlign: TextAlign.center,
                ),
                getHeightSizedBox(h: 23),
                socialButtons(),
                getHeightSizedBox(h: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  forgotPasswordButton() {
    return GestureDetector(
      onTap: () {
        disposeKeyboard();

        Get.to(() => ForgotPassword());
      },
      child: Center(
          child: Text(
        'forgot_your_password'.tr,
        style: TextStyle(fontSize: getProportionateScreenWidth(16)),
      )),
    );
  }

  createAnAccountButton() {
    return CustomButton(
        padding: 5,
        type: CustomButtonType.borderButton,
        text: 'create_an_account'.tr,
        onTap: () {
          disposeKeyboard();
          Get.to(() => SignUp());
        });
  }

  loginButton() {
    return CustomButton(
      padding: 5,
      type: CustomButtonType.colourButton,
      text: 'login'.tr,
      onTap: () {
        disposeKeyboard();
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          loginController.userLogin()
            ..whenComplete(
              () {
                try {
                  if (loginController.currentUserModel!.code == 100) {
                    Get.offAll(() => BaseScreen());
                  }
                } catch (e) {
                  print('something went wrong');
                }
              },
            );
        }
      },
    );
  }

  socialButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
    );
  }

  orDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'or'.tr,
            style: TextStyle(fontSize: getProportionateScreenWidth(16)),
          ),
        ),
        Expanded(
          child: Divider(),
        ),
      ],
    );
  }

  emailField() {
    return CustomTextField(
      controller: loginController.email,
      hintText: 'email_example'.tr,
      keyboardType: TextInputType.emailAddress,
      validator: (val) => val!.isEmpty
          ? 'enter_email'.tr
          : val.isValidEmail()
              ? null
              : 'invalid_email'.tr,
    );
  }

  passwordFiled() {
    return Obx(
      () => CustomTextField(
        hintText: 'password_example'.tr,
        suffixWidth: 40,
        controller: loginController.password,
        keyboardType: TextInputType.visiblePassword,
        obSecureText: loginController.showText.value,
        suffix: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            loginController.showText.toggle();
          },
          icon: Text(
            loginController.showText.value ? 'show'.tr : 'hide'.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        validator: (val) => val!.isEmpty
            ? 'enter_password'.tr
            : val.length >= 5
                ? null
                : 'invalid_password'.tr,
      ),
    );
  }
}

header(String title) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(18)),
      ),
      // Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
    ],
  );
}
