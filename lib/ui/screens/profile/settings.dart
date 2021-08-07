import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/ui/screens/homeTab/home.dart';
import 'package:greboo/ui/screens/onbording.dart';
import 'package:greboo/ui/screens/profile/settingslist.dart';
import 'package:greboo/ui/shared/appbar.dart';

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
        Get.to(() => ContactAdmin());
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
        Get.to(() => OnBoarding());
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
                        contentPadding: EdgeInsets.zero.copyWith(top: 3),
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
                        height: 5,
                        thickness: 1,
                      )
                    ],
                  ),
                )),
      ),
    );
  }
}