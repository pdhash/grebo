import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/utils/sharedpreference.dart';
import 'package:grebo/ui/screens/baseScreen/controller/baseController.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/profile/contactAdminScreen.dart';
import 'package:grebo/ui/screens/profile/settingslist.dart';
import 'package:grebo/ui/screens/selectservice.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';

import 'faqs.dart';

class Settings extends StatelessWidget {
  final List<Map<String, dynamic>> list = [
    {
      'image': buildWidget(AppImages.aboutUs, 20, 20),
      'title': 'about_us'.tr,
      'onTap': () {
        Get.to(() => AboutUsAndTAndC(
              screenType: DescriptionScreen.aboutUs,
            ));
      }
    },
    {
      'image': buildWidget(AppImages.terms, 20, 20),
      'title': 'terms'.tr,
      'onTap': () {
        Get.to(() => AboutUsAndTAndC(
              screenType: DescriptionScreen.termsAndConditions,
            ));
      }
    },
    {
      'image': buildWidget(AppImages.contactAdmin, 20, 20),
      'title': 'contact_admin'.tr,
      'onTap': () {
        Get.to(() => ContactAdminScreen());
      }
    },
    {
      'image': buildWidget(AppImages.faqs, 20, 20),
      'title': 'faqs'.tr,
      'onTap': () {
        Get.to(() => Faqs());
      }
    },
    {
      'image': buildWidget(AppImages.logOut, 20, 20),
      'title': 'logOut'.tr,
      'onTap': () {
        logoutConfirmation(yesTap: () {
          UserRepo.userLogout();
          removerUserDetail();
          Get.find<BaseController>().resetInitialTab();
          Get.offAll(() => ChooseServices());
        });
      }
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('settings'.tr),
      body: Column(
        children: List.generate(
            5,
            (index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: list[index]['onTap'],
                        contentPadding: EdgeInsets.zero.copyWith(top: 2),
                        horizontalTitleGap: 0,
                        leading: list[index]['image'],
                        title: Text(
                          list[index]['title'],
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(17)),
                        ),
                        trailing: list[index]['title'] != 'logOut'.tr
                            ? buildWidget(AppImages.next, 17, 9)
                            : SizedBox(),
                      ),
                      Divider(
                        height: 2,
                        thickness: 1,
                      )
                    ],
                  ),
                )),
      ),
    );
  }
}

logoutConfirmation({required Function() yesTap}) {
  showDialog(
    context: Get.context as BuildContext,
    builder: (ctx) => PlatformCheck.isAndroid
        ? AlertDialog(
            title: Text("logout".tr),
            content: Text("logOutMsg".tr),
            actions: <Widget>[
              TextButton(
                onPressed: yesTap,
                child: Text("yes".tr),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("no".tr),
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: new Text("logout".tr),
            content: new Text("logOutMsg".tr),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: yesTap,
                child: Text("logoutPop".tr),
              ),
              CupertinoDialogAction(
                child: Text(
                  "cancel".tr,
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
  );
}
