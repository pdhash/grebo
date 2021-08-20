import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/homescreencontroller.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/ui/screens/homeTab/businessprofile.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/homeTab/serviceoffered.dart';
import 'package:grebo/ui/screens/profile/provider/availability.dart';
import 'package:grebo/ui/screens/profile/settings.dart';
import 'package:grebo/ui/shared/postview.dart';

import 'editprofile.dart';

class Profile extends StatelessWidget {
  final HomeScreenController homeScreenController =
      Get.find<HomeScreenController>();

  final List<Map<String, dynamic>> list = [
    {
      'title': 'about_business'.tr,
      'onTap': () {
        Get.to(() => BusinessProfile(
              isShow: true,
            ));
      },
      "image": AppImages.aboutBusiness
    },
    {
      'title': 'availability'.tr,
      'onTap': () {
        Get.to(() => Availability());
      },
      "image": AppImages.availability
    },
    {
      'title': 'services_offered'.tr,
      'onTap': () {
        Get.to(() => ServiceOffered(
              isEdit: true,
            ));
      },
      "image": AppImages.serviceOffer
    },
    {
      'title': 'settings'.tr,
      'onTap': () {
        Get.to(() => Settings());
      },
      "image": AppImages.setting
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              buildCircleProfile(
                  height: 122, width: 122, image: AppImages.defaultProfile),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                      onTap: () {
                        Get.to(() => EditProfile());
                      },
                      child: buildWidget(AppImages.edit, 38, 38)))
            ],
          ),
          getHeightSizedBox(h: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xffEDEDED),
                      offset: Offset(0, 1),
                      blurRadius: 6)
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  buildSettingTile(
                    image: AppImages.user,
                    height: 21,
                    width: 17,
                    title: 'user_name'.tr,
                    subtitle: 'Ranjit Singh',
                  ),
                  homeScreenController.serviceController.servicesType ==
                          ServicesType.userType
                      ? buildSettingTile(
                          image: AppImages.location,
                          height: 20,
                          width: 14,
                          title: 'location'.tr,
                          subtitle:
                              'Villaz Johns Street 11, California Johns Street 11, California',
                        )
                      : SizedBox(),
                  buildSettingTile(
                    image: AppImages.email,
                    height: 20,
                    width: 20,
                    title: 'email_address'.tr,
                    subtitle: 'example@mail.com',
                  ),
                ],
              ),
            ),
          ),
          getHeightSizedBox(h: 10),
          homeScreenController.serviceController.servicesType ==
                  ServicesType.userType
              ? buildTile(
                  'settings'.tr,
                  () {
                    Get.to(() => Settings());
                  },
                  AppImages.setting,
                )
              : Column(
                  children: List.generate(
                      list.length,
                      (index) => buildTile(list[index]['title'],
                          list[index]['onTap'], list[index]['image'])),
                ),
          Divider(
            height: 0,
          )
        ],
      ),
    );
  }
}

Widget buildSettingTile(
    {required String image,
    required String title,
    required String subtitle,
    required double height,
    required double width}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      buildWidget(image, height, width),
      Expanded(
        child: ListTile(
          minVerticalPadding: 5,
          tileColor: Colors.blue.shade50,
          title: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(13)),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              subtitle,
              style: TextStyle(
                  color: Color(0xff6E6E6E).withOpacity(0.85),
                  fontSize: getProportionateScreenWidth(14)),
            ),
          ),
        ),
      )
    ],
  );
}
