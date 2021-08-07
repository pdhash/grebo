import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/ui/screens/homeTab/businessprofile.dart';
import 'package:greboo/ui/screens/homeTab/home.dart';
import 'package:greboo/ui/screens/profile/settings.dart';
import 'package:greboo/ui/shared/postview.dart';

import 'editprofile.dart';

class Profile extends StatelessWidget {
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
                  buildSettingTile(
                    image: AppImages.location,
                    height: 20,
                    width: 14,
                    title: 'location'.tr,
                    subtitle:
                        'Villaz Johns Street 11, California Johns Street 11, California',
                  ),
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
          buildTile(
            'settings'.tr,
            () {
              Get.to(() => Settings());
            },
            AppImages.setting,
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
